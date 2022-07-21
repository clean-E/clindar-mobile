import 'package:clindar_mobile/provider/login_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class JoinPage extends StatefulWidget {
  // 앱 메인페이지
  const JoinPage({Key? key}) : super(key: key);

  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  late TextEditingController _emailController;
  late TextEditingController _nicknameController;
  late GoogleSignInAccount _account;
  late UserProvider userProvider = UserProvider();

  _JoinPageState() {
    _emailController = TextEditingController();
    _nicknameController = TextEditingController();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (Get.arguments.containsKey('account')) {
      _account = Get.arguments['account'];
    } else {
      Get.offAllNamed('/login_screen');
    }
    // if (args != null) {
    //   var find = Get.find<Member>();
    //   User user = find.getMember(args['index']);
    _emailController.text = _account.email;
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
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(207, 223, 176, 181)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    )),
                  ),
                  onPressed: () {
                    // userProvider.addUser(
                    //     _emailController.text,
                    //     _nicknameController.text,
                    // userProvider
                    //     .loginUser(_account.email, _account.email)
                    //     .then((value) {
                    //   Get.offAllNamed('/home_page', arguments: {
                    //     'account': _account,
                    //     'user': userProvider
                    //   }
                    //   );
                    // }
                    // );
                  },
                  child: Container(
                      margin: EdgeInsets.symmetric(vertical: 15),
                      child: Text('Register')),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
