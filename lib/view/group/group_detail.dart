import 'package:clindar_mobile/graphQL/query_mutation.dart';
import 'package:clindar_mobile/view/group/group.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GroupDetail extends StatefulWidget {
  GroupDetail(
      {Key? key,
      required this.groupInfo,
      required this.userInfo,
      required this.setGroupPage})
      : super(key: key);
  Map groupInfo;
  Map userInfo;
  Function setGroupPage;

  @override
  State<GroupDetail> createState() => _GroupDetailState();
}

class _GroupDetailState extends State<GroupDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: 115,
            width: 115,
            child: Stack(
              fit: StackFit.expand,
              clipBehavior: Clip.none,
              children: [CircleAvatar()],
            ),
          ),
          Text(widget.groupInfo['gname']),
          Text(widget.groupInfo['mainCategory']),
          Text(widget.groupInfo['leader']),
          Text(widget.groupInfo['createdAt']),
          Text(widget.groupInfo['description']),
          for (int i = 0; i < widget.groupInfo['memberList'].length; i++)
            Text(widget.groupInfo['memberList'][i]),
          Mutation(
              options: MutationOptions(
                document: gql(QueryAndMutation.deleteGroup),
                update: ((cache, result) {}),
                onCompleted: (data) {},
              ),
              builder: ((runMutation, result) => TextButton.icon(
                  onPressed: () {
                    runMutation({
                      'group': {
                        'email': widget.userInfo['email'],
                        '_id': widget.groupInfo['_id']
                      }
                    });

                    Navigator.pop(context);
                    widget.setGroupPage();
                    return;
                  },
                  icon: Icon(Icons.delete),
                  label: Text('그룹 삭제')))),
        ],
      ),
    );
  }
}
