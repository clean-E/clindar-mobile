// import 'package:clindar_flutter/graphQL.dart/mutations.dart';
import 'package:clindar_mobile/widget/logged_in_widget.dart';
import 'package:clindar_mobile/widget/sign_up_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  late User userinfo;
  // final user = FirebaseAuth.instance.currentUser!;
  //const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          //<Object>
          stream: FirebaseAuth.instance.authStateChanges(), // 로그인 상태
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              // 로그인 데이터 o
              print('snapshot : ${snapshot}');
              return LoggedInWidget();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Something Went Wrong!'),
              );
            } else {
              // 로그인 데이터 x
              return SignUpWidget();
            }
          }),
    );
  }
}
