// import 'package:clindar_flutter/graphQL.dart/mutations.dart';
import 'package:clindar_mobile/graphQL/query_mutation.dart';
import 'package:clindar_mobile/view/join.dart';
import 'package:clindar_mobile/widget/logged_in_widget.dart';
import 'package:clindar_mobile/widget/sign_up_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          //<Object>
          stream: FirebaseAuth.instance.authStateChanges(), // 로그인 상태
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              // 로그인 데이터 o
              final user = FirebaseAuth.instance.currentUser!;
              return Query(
                  options: QueryOptions(
                      document: gql(QueryAndMutation.getMyPage),
                      variables: {
                        'user': {'email': user.email}
                      }),
                  builder: ((result, {fetchMore, refetch}) {
                    print('result.data: ${result.data}');
                    if (result.hasException) {
                      return Text(result.exception.toString());
                    }
                    if (result.isLoading) {
                      return Text('Loading..');
                    }
                    if (result.data!['getMyPage']['nickname'] == '') {
                      return JoinPage();
                    }
                    return LoggedInWidget();
                  }));
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Something Went Wrong!'),
              );
            } else {
              // 로그인 데이터 x
              return SignUpWidget();
            }
          }),
    );
  }
}
