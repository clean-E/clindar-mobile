import 'package:clindar_mobile/graphQL/query_mutation.dart';
import 'package:clindar_mobile/provider/google_sign_in.dart';
import 'package:clindar_mobile/provider/login_service.dart';
import 'package:clindar_mobile/provider/set_nickname_provider.dart';
import 'package:clindar_mobile/view/home.dart';
import 'package:clindar_mobile/view/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

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

  Future createNickName(String email, String nickname) async {
    final setNickNameValue =
        await Provider.of<SetNicknameProvider>(context, listen: false)
            .setNickname(email: email, nickname: nickname);
    setState(() {});
    ChangeNotifier();
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
                child: Consumer<SetNicknameProvider>(
                  builder: (context, value, child) {
                    WidgetsBinding.instance!.addPostFrameCallback((_) {
                      if (value.getResponse != '') {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(value.getResponse)));
                        value.clear();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginService()));
                      }
                    });
                    return GestureDetector(
                      onTap: value.getStatus == true
                          ? null
                          : () {
                              if (_nicknameController.text.isNotEmpty) {
                                value.setNickname(
                                    email: _emailController.text,
                                    nickname: _nicknameController.text);
                              }
                              print(value.getResponse);
                            },
                      child: Container(
                          padding: const EdgeInsets.all(15),
                          margin: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              color: value.getStatus == true
                                  ? Colors.grey
                                  : Colors.blue,
                              borderRadius: BorderRadius.circular(10)),
                          child: Text(value.getStatus == true
                              ? 'Loading...'
                              : 'Save Task')),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
// FractionallySizedBox(
//                   widthFactor: 1,
//                   child: Mutation(
//                       options: MutationOptions(
//                         document: gql(QueryAndMutation.login),
//                         update: (cache, result) {
//                           return cache;
//                         },
//                         onCompleted: ((data) {
//                           print('N Mutation data:${data}');
//                           // return HomePage();
//                         }),
//                         onError: (error) {
//                           print('N error:${error}');
//                         },
//                       ),
//                       builder: ((runMutation, result) => ElevatedButton(
//                             onPressed: () async {
//                               final user = FirebaseAuth.instance.currentUser!;
//                               runMutation({
//                                 'userInfo': {
//                                   'email': user.email,
//                                   'nickname': _nicknameController.text
//                                 }
//                               });
//                               final provider =
//                                   Provider.of<GoogleSignInProvider>(context,
//                                       listen: false);
//                               await provider.googleLogin();
//                             },
//                             child: Container(
//                                 margin: EdgeInsets.symmetric(vertical: 15),
//                                 child: Text('Register')),
//                           ))))
