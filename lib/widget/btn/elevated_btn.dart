import 'package:clindar_mobile/theme/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class ElevatedBtn extends StatelessWidget {
  ElevatedBtn({Key? key, required this.text, required this.runMutation})
      : super(key: key);
  late String text;
  RunMutation runMutation;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () async {
        runMutation;
      },
      icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
      label: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      ),
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          ),
          minimumSize: MaterialStateProperty.all(Size(250, 50)),
          backgroundColor: MaterialStateProperty.all(LightColors.kGreen)),
    );
  }
}
