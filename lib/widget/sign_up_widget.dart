import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import '../graphQL/query_mutation.dart';
import '../provider/google_sign_in.dart';

class SignUpWidget extends StatelessWidget {
  late User userinfo;
  // final user = FirebaseAuth.instance.currentUser!;
  //const SignUpWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Text('CLINDAR',
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold)),
          Spacer(),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              '클라이머들의 일지, \n클린더',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Login to your account to continue',
              style: TextStyle(fontSize: 16),
            ),
          ),
          Spacer(),
          // ElevatedButton.icon(
          //     onPressed: () {
          //       final provider =
          //           Provider.of<GoogleSignInProvider>(context, listen: false);
          //       provider.googleLogin();
          //       print('provider : ${provider}');
          //     },
          //     icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
          //     label: Text('Sign Up with Google')),

          Mutation(
              options: MutationOptions(
                  document: gql(QueryAndMutation.login),
                  update: (GraphQLDataProxy cache, result) {
                    return cache;
                  },
                  onCompleted: (data) {
                    //mutation이 완료되었을 때 실행되는 부분
                    print('Mutation data:${data}');
                  },
                  onError: (e) {
                    //error시 실행되는 부분
                    print('error:${e}');
                  }),
              builder: (RunMutation runMutation, result) => ElevatedButton.icon(
                  onPressed: () async {
                    final provider = Provider.of<GoogleSignInProvider>(context,
                        listen: false);
                    await provider.googleLogin();

                    final user = FirebaseAuth.instance.currentUser!;
                    //print('user : ${user}');
                    runMutation({
                      'user': {'email': user.email, 'nickname': ""}
                    });
                  },
                  icon: FaIcon(FontAwesomeIcons.google, color: Colors.red),
                  label: Text('Sign Up with Google'))),
          SizedBox(
            height: 40,
          ),
          RichText(
              text: TextSpan(text: 'Already have an account?', children: [
            TextSpan(
                text: 'Log in',
                style: TextStyle(decoration: TextDecoration.underline))
          ]))
        ],
      ),
    );
  }
}
// 이메일 추출 > 서버로 전달

// Mutation(
//   options: MutationOptions(
//     document: gql(Mutations.loginMutation),
//     update: (cache, result) => result,
//     onCompleted: (data) {
//       //mutation이 완료되었을 때 실행되는 부분
//     },
//     onError: (e){}
//   ),
//   builder: (runMutation ,result) {
//     runMutation({
//       "user":{
//         "email":user.email,
//         "nickname":""
//       }
//     });
//   },
// );