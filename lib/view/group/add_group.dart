import 'package:clindar_mobile/graphQL/query_mutation.dart';
import 'package:clindar_mobile/theme/light_colors.dart';
import 'package:clindar_mobile/view/group/group.dart';
import 'package:clindar_mobile/widget/btn/register_btn.dart';
import 'package:clindar_mobile/widget/btn/tgl_btn.dart';
import 'package:clindar_mobile/widget/field/txt_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class AddGroup extends StatefulWidget {
  AddGroup({Key? key, required this.userInfo, required this.setGroupList})
      : super(key: key);
  Map userInfo;
  Function setGroupList;
  @override
  State<AddGroup> createState() => _AddGroupState();
}

class _AddGroupState extends State<AddGroup> {
  late List category = ['볼더링', '공개'];
  late TextEditingController _gnameController;
  late TextEditingController _descController;
  late TextEditingController _gPwController;
  String gCreateTime = DateTime.now().toString();

  void setCategory(int bnum, int index, List type) {
    setState(() {
      category[bnum] = type[index];
    });
  }

  _AddGroupState() {
    _gnameController = TextEditingController();
    _descController = TextEditingController();
    _gPwController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Column(
        children: [
          TxtField(
              label: 'Group Name',
              maxLines: 1,
              minLines: 1,
              icon: Icon(Icons.groups),
              controller: _gnameController),
          TxtField(
              label: 'Group Discription',
              maxLines: 3,
              minLines: 1,
              icon: Icon(Icons.group_work),
              controller: _descController),
          Togglebtn(
              type1: "볼더링",
              type2: "리드",
              bnum: 0,
              setCategory: setCategory,
              tcolor: LightColors.kGreen),
          Togglebtn(
              type1: "공개",
              type2: "비공개",
              bnum: 1,
              setCategory: setCategory,
              tcolor: LightColors.kRed),
          Visibility(
            child: TxtField(
                label: 'Group Password',
                maxLines: 1,
                minLines: 1,
                icon: Icon(Icons.group_work),
                controller: _gPwController),
            visible: category[1] == "공개" ? false : true,
          ),
          Mutation(
              options: MutationOptions(
                document: gql(QueryAndMutation.createGroup),
                update: (cache, result) {
                  return cache;
                },
                onCompleted: ((data) {}),
                onError: (error) {
                  print('G error:${error}');
                },
              ),
              builder: ((runMutation, result) => TextButton(
                    onPressed: () async {
                      runMutation({
                        'group': {
                          'email': widget.userInfo['email'],
                          'gname': _gnameController.text,
                          'leader': widget.userInfo['nickname'],
                          'createdAt': gCreateTime,
                          'description': _descController.text,
                          'mainCategory': category[0],
                          'secret': category[1] == "공개" ? true : false,
                        }
                      });
                      widget.setGroupList();
                      Navigator.pop(context);
                      return;
                    },
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(
                          'Create Group',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 18),
                        ),
                      ),
                      alignment: Alignment.center,
                      margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      width: width * 0.8,
                      decoration: BoxDecoration(
                        color: LightColors.kBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ))),
        ],
      ),
    );
  }
}
