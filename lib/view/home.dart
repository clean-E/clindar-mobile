import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../provider/google_sign_in.dart';

class LoggedInWidget extends StatelessWidget {
  //final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  //const LoggedInWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    print('logged in : ${user.email}');

    return Scaffold(
      appBar: AppBar(title: Text('Clindar'), centerTitle: true, actions: [
        TextButton(
            onPressed: () {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              provider.logout();
            },
            child: Text('Logout'))
      ]),
      body: Container(
          alignment: Alignment.center,
          color: Colors.blueGrey.shade900,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Text('Home')],
          )),
    );
  }
}
