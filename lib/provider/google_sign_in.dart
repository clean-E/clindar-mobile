import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  // 회원정보(이메일, 닉네임, ...)
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  // 로그인 method
  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn(); // 로그인 팝업
      if (googleUser == null) return;
      _user = googleUser; // 회원정보 저장

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print('_user : ${_user}');
      await FirebaseAuth.instance.signInWithCredential(credential);
    } catch (e) {
      print(e.toString());
    }

    notifyListeners(); // UI Update
  }

  Future logout() async {
    await googleSignIn.signOut();
    FirebaseAuth.instance.signOut();
  }
}
