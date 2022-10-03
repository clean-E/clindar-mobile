import 'package:clindar_mobile/theme/light_colors.dart';
import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget {
  MyBackButton({Key? key, required this.data}) : super(key: key);
  late String data;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'backButton',
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Row(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Icon(
                Icons.arrow_back_ios,
                size: 25,
                color: Colors.white,
              ),
            ),
            Text(
              data,
              style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
