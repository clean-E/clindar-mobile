import 'package:clindar_mobile/provider/search.dart';
import 'package:flutter/material.dart';
import 'package:clindar_mobile/theme/light_colors.dart';

class SearchField extends StatefulWidget {
  SearchField({Key? key, required this.setWhere}) : super(key: key);
  Function setWhere;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late TextEditingController _placeController = TextEditingController();
  late String place = '';
  FocusNode focusNode = FocusNode(); // 현재 검색 위젯에 커서가 있는지에 대한 상태를 가지고 있는 위젯

  _SearchPlaceState() {
    _placeController = TextEditingController();
  }

  void setPlace(String place) {
    setState(() {
      _placeController.text = place;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextField(
        onTap: () {
          showSearch(
              context: context,
              delegate: CustomSearchDelegate(
                  setPlace: setPlace, setWhere: widget.setWhere));
        },
        focusNode: focusNode,
        controller: _placeController,
        decoration: InputDecoration(
            prefixIconColor: LightColors.kGreen,
            filled: true,
            focusColor: Colors.black,
            hintText: "암장을 검색하세요.",
            hintStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            prefixIcon: Icon(Icons.place),
            suffixIcon: focusNode.hasFocus
                ? IconButton(
                    onPressed: () {
                      setState(() {
                        _placeController.clear();
                        place = '';
                        focusNode.unfocus();
                      });
                    },
                    icon: Icon(Icons.cancel),
                  )
                : Icon(Icons.search)),
      ),
    );
  }
}
