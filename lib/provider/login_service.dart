// import 'package:clindar_flutter/graphQL.dart/mutations.dart';
import 'package:clindar_mobile/graphQL/query_mutation.dart';
import 'package:clindar_mobile/view/signature/join.dart';
import 'package:clindar_mobile/view/home.dart';
import 'package:clindar_mobile/view/signature/sign_up.dart';
import 'package:clindar_mobile/widget/bar/tab_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class LoginService extends StatefulWidget {
  @override
  State<LoginService> createState() => _LoginServiceState();
}

class _LoginServiceState extends State<LoginService> {
  @override
  Widget build(BuildContext context) {
    void setPage() {
      setState(() {});
    }

    return Scaffold(
      body: StreamBuilder(
          //<Object>
          stream: FirebaseAuth.instance.authStateChanges(), // 로그인 상태
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
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
                      print(result.exception.toString());
                      return Text(result.exception.toString());
                    }
                    if (result.isLoading) {
                      return Center(child: Text('Loading..'));
                    } else if (result.data!['getMyPage']['nickname'] == '') {
                      return JoinPage();
                    } else {
                      return Query(
                          options: QueryOptions(
                              document: gql(QueryAndMutation.getAllSchedule),
                              variables: {
                                'schedule': {'email': user.email}
                              }),
                          builder: (schedule, {fetchMore, refetch}) {
                            if (schedule.isLoading) {
                              return CircularProgressIndicator();
                            } else {
                              if (schedule.data?['getAllSchedule'] != null) {
                                // print(
                                //     'schedule.data?["getAllSchedule"]: ${schedule.data?['getAllSchedule']}');
                                return HomeTabBar(
                                  mySchedules: schedule.data!['getAllSchedule'],
                                  userInfo: result.data!['getMyPage'],
                                );
                              } else {
                                return HomeTabBar(
                                  mySchedules: [],
                                  userInfo: result.data!['getMyPage'],
                                );
                              }
                            }
                          });
                    }
                  }));
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Something Went Wrong!'),
              );
            } else {
              // 로그인 데이터 x
              return SignUpPage();
            }
          }),
    );
  }
}
