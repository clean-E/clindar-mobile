import 'package:clindar_mobile/graphQL/query_mutation.dart';
import 'package:clindar_mobile/provider/login_service.dart';
import 'package:clindar_mobile/widget/logged_in_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class JoinPage extends StatefulWidget {
  // 앱 메인페이지
  const JoinPage({Key? key}) : super(key: key);

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  late TextEditingController _emailController;
  late TextEditingController _nicknameController;
  final user = FirebaseAuth.instance.currentUser!;
  // late GoogleSignInAccount _account;
  // late UserProvider userProvider = UserProvider();

  _JoinPageState() {
    _emailController = TextEditingController();
    _nicknameController = TextEditingController();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _emailController.text = user.email!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Account'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: "E-mail",
                suffixIcon: Icon(Icons.email_outlined),
              ),
            ),
            TextField(
              controller: _nicknameController,
              decoration: InputDecoration(
                labelText: 'Nickname',
                suffixIcon: Icon(Icons.account_circle),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(40),
              child: FractionallySizedBox(
                  widthFactor: 1,
                  child: Mutation(
                      options: MutationOptions(
                        document: gql(QueryAndMutation.setNickname),
                        update: (cache, result) {
                          return cache;
                        },
                        onCompleted: ((data) {
                          print('N Mutation data:${data}');
                          return LoggedInWidget();
                        }),
                        onError: (error) {
                          print('N error:${error}');
                        },
                      ),
                      builder: ((runMutation, result) => ElevatedButton(
                            onPressed: () {
                              runMutation({
                                'user': {
                                  'email': user.email,
                                  'nickname': _nicknameController.text
                                }
                              });
                            },
                            child: Container(
                                margin: EdgeInsets.symmetric(vertical: 15),
                                child: Text('Register')),
                          )))),
            ),
          ],
        ),
      ),
    );
  }
}
