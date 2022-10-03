import 'package:clindar_mobile/data/level.dart';
import 'package:clindar_mobile/widget/field/drpdwn_field.dart';
import 'package:flutter/material.dart';

class WorkOutRecord extends StatefulWidget {
  WorkOutRecord({Key? key, required this.category}) : super(key: key);

  List category;
  @override
  State<WorkOutRecord> createState() => _WorkOutRecordState();
}

class _WorkOutRecordState extends State<WorkOutRecord> {
  @override
  Widget build(BuildContext context) {
    String lv;
    List theme;
    widget.category[0] == '리드'
        ? theme = leadLevel
        : widget.category[1] == '실내'
            ? theme = bolderIndoorLevel
            : theme = bolderOutdoorLevel;
    return Container(
      child: CustDropDown(
        items: [
          for (var level in theme)
            CustDropdownMenuItem(child: Text("${level}"), value: level),
        ],
        onChanged: (val) {
          lv = val;
        },
        hintText: "Choose Level",
        borderRadius: 5,
      ),
    );
  }
}

// class BolderIndoorIcons extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return CustDropdownMenuItem(child: Icon(
//                                 Icons.circle,
//                                 color: Colors.value,
//                               ));
//   }
// }
