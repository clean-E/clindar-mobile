import 'package:get/get_connect.dart';

class UserProvider extends GetConnect {
  String email = '';
  String nickname = '';
  String token = '';
  bool is_login = false;

  Future<void> addUser(String email, String nickname) async {}

  void deleteUser() {}

  Future<int> loginUser(String email, String nickname) async {
    //   if () {
    //   is_login = true;
    //   if () {

    //   }
    // }
    return -1;
  }
}
