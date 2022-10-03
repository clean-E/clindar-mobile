import 'package:clindar_mobile/graphQL/query_mutation.dart';
import 'package:clindar_mobile/theme/light_colors.dart';
import 'package:clindar_mobile/view/home.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class RegisterBtn extends StatelessWidget {
  RegisterBtn(
      {Key? key,
      required this.name,
      required this.width,
      required this.runMutation,
      required this.height})
      : super(key: key);
  final String name;
  final double width;
  final double height;

  late MultiSourceResult<Object?> runMutation;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        runMutation;
      },
      child: Text(name),
      style: TextButton.styleFrom(
        primary: Colors.white,
        textStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
        minimumSize: Size(width, height),
        backgroundColor: LightColors.kBlue,
        shape: StadiumBorder(),
      ),
    );
  }
}
