import 'package:clindar_mobile/graphQL/config.dart';
import 'package:clindar_mobile/graphQL/query_mutation.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class AddScheduleProvider extends ChangeNotifier {
  bool _status = false; // 비공개 설정
  String _response = '';

  bool get getStatus => _status;
  String get getResponse => _response;

  final Config _config = Config();

  // 일정 추가 메소드
  void addSchedule(
      {String? email,
      List? category,
      String? when,
      String? nickname,
      String? memo,
      String? where,
      String? group,
      String? status}) async {
    _status = true;
    _response = "Please wait...";
    notifyListeners();

    ValueNotifier<GraphQLClient> _client = Config.initClient();

    QueryResult result = await _client.value.mutate(MutationOptions(
        document: gql(QueryAndMutation.createSchedule),
        variables: {
          'schedule': {
            'email': email,
            'category': category,
            'when': when,
            'who': {
              'host': nickname,
              'guest': [
                {'nickname': nickname, 'record': []}
              ]
            },
            'memo': memo,
            'where': where,
            'group': group
          }
        }));

    // 성공여부 확인
    if (result.hasException) {
      print(result.exception);
      _status = false;
      if (result.exception!.graphqlErrors.isEmpty) {
        _response = "Internet is not found";
      } else {
        _response = result.exception!.graphqlErrors[0].message.toString();
      }
      notifyListeners();
    } else {
      print(result.data);
      _status = false;
      _response = "Task was successfully added";
      notifyListeners();
    }
  }

  void clear() {
    _response = '';
    notifyListeners();
  }

  void getSchedule() {}
  void editSchedule() {}
  void deleteSchedule() {}
}
