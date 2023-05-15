import 'package:clindar_mobile/graphQL/config.dart';
import 'package:clindar_mobile/graphQL/query_mutation.dart';
import 'package:flutter/foundation.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class SetNicknameProvider extends ChangeNotifier {
  bool _status = false;
  String _response = '';
  bool get getStatus => _status;
  String get getResponse => _response;

  Future setNickname({String? email, String? nickname}) async {
    _status = true;
    _response = "Please wait...";
    notifyListeners();

    MutationOptions mutationOptions =
        MutationOptions(document: gql(QueryAndMutation.login), variables: {
      "userInfo": {"email": email, "nickname": nickname}
    });

    QueryResult result =
        await Config.initClient().value.mutate(mutationOptions);

    if (result.hasException) {
      print(result.exception);
      _status = false;
      if (result.exception!.graphqlErrors.isEmpty) {
        _response = "Internet is not found.";
      } else {
        _response = result.exception!.graphqlErrors[0].message.toString();
      }
      notifyListeners();
    } else {
      _status = false;
      _response = "Nickname was successfully setted.";
    }
    final resultData = result.data?["createRecord"];
    notifyListeners();
    return _response;
  }

  void clear() {
    _response = '';
    notifyListeners();
  }
}
