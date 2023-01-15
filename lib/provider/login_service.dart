import 'package:clindar_mobile/graphQL/config.dart';
import 'package:clindar_mobile/graphQL/query_mutation.dart';
import 'package:clindar_mobile/provider/google_sign_in.dart';
import 'package:clindar_mobile/widget/btn/elevated_btn.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  String token = '';
  String id = '';
  String nickname = '';
  bool _loginStatus = false;
  String _response = '';
  late GoogleSignInProvider _user;

  bool get getLoginStatus => _loginStatus;
  String get getResponse => _response;
  GoogleSignInProvider get user => _user;

  final Config _config = Config();

  Future<void> getUser(String email, String nickname) async {
    ValueNotifier<GraphQLClient> _client = Config.initClient();

    QueryResult result = await _client.value.query(QueryOptions(
      document: gql(QueryAndMutation.getUser),
      // fetchPolicy: isLocal == true ? null : FetchPolicy.networkOnly
    ));

    if (result.hasException) {
      print(result.exception);
      _loginStatus = false;
      if (result.exception!.graphqlErrors.isEmpty) {
        _response = 'Internet is not found';
      } else {
        _response = result.exception!.graphqlErrors[0].message.toString();
      }
      notifyListeners();
    } else {
      print(result.data);
      _loginStatus = false;
      token = result.data!['token'];
      id = result.data!['id'];
      nickname = result.data!['nickname'];
      notifyListeners();
    }

    // Mutation(
    //   builder: (MultiSourceResult<dynamic> Function(Map<String, dynamic>, {Object? optimisticResult}) runMutation, QueryResult<dynamic>? result) => ElevatedBtn(
    //     text: 'Sign Up with Google',
    //     runMutation: runMutation({
    //                     'user': {'email': _user.email, 'nickname': _user.nickname}
    //                   });),
    //   options:  MutationOptions(
    //               document: gql(QueryAndMutation.login),
    //               update: (GraphQLDataProxy cache, result) {
    //                 return cache;
    //               },
    //               onCompleted: (data) {
    //                 //mutation이 완료되었을 때 실행되는 부분
    //                 print('Mutation data:${data}');
    //               },
    //               onError: (e) {
    //                 //error시 실행되는 부분
    //                 print('error:${e}');
    //               }),);
  }

  dynamic getResposneData() {
    if (id.isNotEmpty) {
      final data = id;
      print(id);
      return data ?? '';
    } else {
      return '';
    }
  }

  void clear() {
    _response = '';
    notifyListeners();
  }
}
