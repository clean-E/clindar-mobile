import 'package:flutter/material.dart';

class TextPlusIcon extends StatelessWidget {
  TextPlusIcon(
      {Key? key, required this.text, required this.icon, required this.title})
      : super(key: key);
  String title;
  String text;
  IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(icon),
          ),
          Column(
            children: [
              Visibility(
                visible: (title == '') ? false : true,
                child: Text(
                  title,
                ),
              ),
              Text(text),
            ],
          )
        ],
      ),
    );
  }
}
