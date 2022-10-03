import 'package:clindar_mobile/theme/light_colors.dart';
import 'package:flutter/material.dart';

class Togglebtn extends StatefulWidget {
  final String type1;
  final String type2;
  final int bnum;
  final Function setCategory;
  final Color tcolor;

  const Togglebtn(
      {Key? key,
      required this.type1,
      required this.type2,
      required this.bnum,
      required this.setCategory,
      required this.tcolor})
      : super(key: key);

  @override
  State<Togglebtn> createState() => _TogglebtnState();
}

class _TogglebtnState extends State<Togglebtn> {
  final List<bool> isSelected = [true, false];

  @override
  Widget build(BuildContext context) {
    List type = [widget.type1, widget.type2];
    return Padding(
      padding: const EdgeInsets.all(6),
      child: ToggleButtons(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(40)),
        borderWidth: 2.0,
        selectedColor: Colors.white,
        disabledColor: Colors.white,
        borderColor: Colors.white,
        selectedBorderColor: Colors.white,
        fillColor: widget.tcolor,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
            child: Text(
              widget.type1,
              // style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 5, 8, 5),
            child: Text(
              widget.type2,
              // style: TextStyle(fontWeight: FontWeight.bold),
            ),
          )
        ],
        onPressed: (int index) {
          for (var buttonIndex = 0;
              buttonIndex < isSelected.length;
              buttonIndex++) {
            if (buttonIndex == index) {
              isSelected[buttonIndex] = true;
              widget.setCategory(widget.bnum, index, type);
            } else {
              isSelected[buttonIndex] = false;
            }
          }
        },
        isSelected: isSelected,
      ),
    );
  }
}
