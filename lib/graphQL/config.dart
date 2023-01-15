import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Config {
  static final HttpLink _httpLink = HttpLink('http://10.0.2.2:3000/graphql');

  // static final AuthLink _authLink = AuthLink(
  //   getToken: () async => 'Bearer <YOUR_PERSONAL_ACCESS_TOKEN>',
  // );

  // static final Link link = _authLink.concat(_httpLink);

  static ValueNotifier<GraphQLClient> initClient() {
    ValueNotifier<GraphQLClient> _client = ValueNotifier(
      GraphQLClient(
        link: _httpLink,
        cache: GraphQLCache(
            // store: HiveStore()
            ), // 기본 메모리 저장소 : 인터넷에 연결되어 있지 않아도 데이터를 가져올 수 있다
      ),
    );

    return _client;
  }
}
