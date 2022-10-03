import 'package:clindar_mobile/graphQL/query_mutation.dart';
import 'package:clindar_mobile/theme/light_colors.dart';
import 'package:clindar_mobile/view/group/add_group.dart';
import 'package:clindar_mobile/view/group/group_detail.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class Group extends StatefulWidget {
  Group({Key? key, required this.userInfo}) : super(key: key);
  Map userInfo;

  @override
  State<Group> createState() => _GroupState();
}

class _GroupState extends State<Group> {
  // late int myGroupCount = widget.userInfo['myGroupList'].length;

  late int myGroupLength = 1;
  void setGroupPage() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text('My Group'),
            ),
            Icon(Icons.arrow_drop_down)
          ],
        ),
        SizedBox(
            height: height * 0.6,
            child: Query(
                options: QueryOptions(
                  document: gql(QueryAndMutation.getMyGroup),
                  variables: {
                    'group': {'email': widget.userInfo['email']}
                  },
                ),
                builder: ((result, {fetchMore, refetch}) {
                  if (result.data != null) {
                    myGroupLength = result.data!['getMyGroup'].length;
                    return ListView.builder(
                      itemCount: myGroupLength,
                      itemBuilder: (context, index) {
                        print(myGroupLength);
                        // print('gresult: ${result.data!['getMyGroup']}');

                        return ListTile(
                          onTap: () {
                            // print(result.data!['getMyGroup'][index]['_id']);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GroupDetail(
                                        setGroupPage: setGroupPage,
                                        userInfo: widget.userInfo,
                                        groupInfo: result.data!['getMyGroup']
                                            [index])));
                          },
                          title:
                              Text(result.data!['getMyGroup'][index]['gname']),
                        );
                      },
                    );
                  } else {
                    return ListTile(title: Text('가입된 그룹이 없습니다.'));
                  }
                }))),
        FloatingActionButton.extended(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddGroup(
                          userInfo: widget.userInfo,
                          setGroupList: setGroupPage,
                        )));
          },
          label: Text("Add Group"),
          icon: Icon(Icons.add),
          backgroundColor: LightColors.kBlue,
        ),
      ]),
    );
  }
}
