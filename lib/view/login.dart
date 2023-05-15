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
              // print(user.email);
              return Query(
                  options: QueryOptions(
                      document: gql(QueryAndMutation.getUser),
                      variables: {'email': user.email}),
                  builder: ((result, {fetchMore, refetch}) {
                    print('getUser : ${result.data}');
                    if (result.hasException) {
                      print('에러! : ${result.exception.toString()}');

                      if (result.exception!.graphqlErrors[0].message ==
                          "User Not Found") {
                        return JoinPage();
                      }
                      return Text("여기까지 오진 않겠지");
                    }
                    if (result.isLoading) {
                      return Center(child: Text('Loading..'));
                    } else if (result.data!['getUser']['nickname'] == '') {
                      return JoinPage();
                    } else {
                      return Query(
                          options: QueryOptions(
                              document: gql(QueryAndMutation.getMySchedule),
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
                                print(result.data!['getUser']);
                                return HomeTabBar(
                                  mySchedules: [],
                                  userInfo: result.data!['getUser'],
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
