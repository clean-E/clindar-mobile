import 'package:clindar_mobile/event.dart';
import 'package:clindar_mobile/graphQL/query_mutation.dart';
import 'package:clindar_mobile/provider/add_schedule_prov.dart';
import 'package:clindar_mobile/theme/light_colors.dart';
import 'package:clindar_mobile/view/home.dart';
import 'package:clindar_mobile/widget/btn/back_button.dart';
import 'package:clindar_mobile/widget/btn/register_btn.dart';
import 'package:clindar_mobile/provider/search.dart';
import 'package:clindar_mobile/widget/field/drpdwn_field.dart';
import 'package:clindar_mobile/widget/field/search_field.dart';
import 'package:clindar_mobile/widget/btn/tgl_btn.dart';
import 'package:clindar_mobile/widget/time_picker.dart';
import 'package:clindar_mobile/widget/top_container.dart';
import 'package:clindar_mobile/widget/field/txt_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

class AddWorkOut extends StatefulWidget {
  AddWorkOut(
      {Key? key,
      required this.userInfo,
      required this.selectedDay,
      required this.selectedEvents,
      required this.setSchedule})
      : super(key: key);
  late Map userInfo;
  DateTime selectedDay;
  late Map<DateTime, List<Event>> selectedEvents;
  Function setSchedule;

  @override
  State<AddWorkOut> createState() => _AddWorkOutState();
}

class _AddWorkOutState extends State<AddWorkOut> {
  late TextEditingController _memoController;
  late TextEditingController _placeController;

  late String where = '';
  late List category = ['볼더링', '실내', '인공'];
  late DateTime when = widget.selectedDay;
  String group = '';

  _AddWorkOutState() {
    _memoController = TextEditingController();
    _placeController = TextEditingController();
  }

  void setDateTime(DateTime dateTime) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        when = dateTime;
      });
    });
  }

  void setCategory(int bnum, int index, List type) {
    setState(() {
      category[bnum] = type[index];
    });
  }

  void setWhere(String place) {
    setState(() {
      where = place;
    });
  }

  // @override
  // void initState() {
  //   selectedEvents = {};
  //   super.initState();
  // }

  // List<Event> _getEventsfromDay(DateTime date) {
  //   return widget.selectedEvents[date] ?? [];
  //   // ?? : 왼쪽 표현식 값이 null이 아니면 왼쪽 표현식, null이면 오른쪽 표현식 return
  // }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          TopContainer(
            padding: EdgeInsets.fromLTRB(16, 20, 16, 30),
            width: width,
            height: height * 0.55,
            child: Column(
              children: [
                MyBackButton(data: "Add WorkOut"),
                Padding(
                    padding: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                    child: SearchField(
                      setWhere: setWhere,
                    )),
                Row(
                  children: [
                    Togglebtn(
                      type1: '볼더링',
                      type2: '리드',
                      bnum: 0,
                      setCategory: setCategory,
                      tcolor: LightColors.kRed,
                    ),
                    Togglebtn(
                      type1: '실내',
                      type2: '실외',
                      bnum: 1,
                      setCategory: setCategory,
                      tcolor: LightColors.kGreen,
                    ),
                    Visibility(
                        visible: (category[0] == '볼더링' && category[1] == '실내')
                            ? false
                            : true,
                        child: Togglebtn(
                          type1: '인공',
                          type2: '자연',
                          bnum: 2,
                          setCategory: setCategory,
                          tcolor: LightColors.kBlue,
                        )),
                  ],
                ),
                SizedBox(height: 15),
                TimePicker(
                  setDateTime: setDateTime,
                  selectedTime: widget.selectedDay,
                )
              ],
            ),
          ),
          TxtField(
            label: 'Memo',
            minLines: 1,
            maxLines: 5,
            icon: Icon(Icons.note_add),
            controller: _memoController,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: CustDropDown(
                  items: [
                    for (var gname in widget.userInfo['myGroupList'])
                      CustDropdownMenuItem(
                          child: Text("${gname}"), value: gname),
                  ],
                  onChanged: (val) {
                    group = val;
                  },
                  hintText: "Group",
                  borderRadius: 5,
                ),
              ),
              Center(
                child: IconButton(
                  padding: EdgeInsets.all(8),
                  color: LightColors.kGreen,
                  // style: ButtonStyle(
                  //     shape:
                  //         MaterialStateProperty.all<RoundedRectangleBorder>(
                  //             RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(18.0),
                  //       // side: BorderSide(color: Colors.red)
                  //     )),
                  //     backgroundColor:
                  //         MaterialStateProperty.all(LightColors.kGreen)),
                  onPressed: () {},
                  icon: Icon(
                    Icons.group_add,
                    color: LightColors.kGreen,
                  ),
                ),
              )
            ],
          ),
          Spacer(),
          // Consumer<AddScheduleProvider>(builder: ((context, value, child) {
          //   WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
          //     if (value.getResponse != '') {
          //       ScaffoldMessenger.of(context)
          //           .showSnackBar(SnackBar(content: Text(value.getResponse)));
          //       value.clear();
          //     }
          //   });
          //   return
          // Build method가 끝난 후 callback
          Consumer<AddScheduleProvider>(builder: (context, schedule, child) {
            WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
              if (schedule.getResponse == '') {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(schedule.getResponse)));
                schedule.clear();
              }
            });
            return GestureDetector(
              onTap: schedule.getStatus == true
                  ? null
                  : () {
                      if (where.isNotEmpty) {
                        schedule.addSchedule(
                            email: widget.userInfo['email'],
                            category: category,
                            when: when.toString(),
                            nickname: widget.userInfo['nickname'],
                            memo: _memoController.text,
                            where: where,
                            group: group,
                            status: 'Pending'); // 보류 중
                      }
                    },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    schedule.getStatus == true
                        ? 'Loading...'
                        : 'Create WorkOut',
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
                  color: schedule.getStatus == true
                      ? Colors.grey
                      : LightColors.kBlue,
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            );
          })
          // ;}))
        ],
      ),
    );
  }
}
// FractionallySizedBox(
//   widthFactor: 1,
//   child: Mutation(
//       options: MutationOptions(
//         document: gql(QueryAndMutation.createSchedule),
//         update: (cache, result) {
//           return cache;
//         },
//         onCompleted: ((data) {
//           print('S Mutation data:${data}');
//           // return HomePage();
//         }),
//         onError: (error) {
//           print('S error:${error}');
//         },
//       ),
//       builder: ((runMutation, result) => TextButton(
//             onPressed: () async {
//               final user = FirebaseAuth.instance.currentUser!;
//               if (where == '') {
//               } else {
//                 runMutation({
//                   'schedule': {
//                     'email': user.email,
//                     'category': category,
//                     'when': when.toString(),
//                     'who': {
//                       'host': widget.userInfo['nickname'],
//                       'guest': [
//                         {
//                           'nickname': widget.userInfo['nickname'],
//                           'record': []
//                         }
//                       ]
//                     },
//                     'memo': _memoController.text,
//                     'where': where,
//                     'group': group
//                   }
//                 });
//                 DateTime date = DateTime.parse(
//                     when.toString().substring(0, 10) +
//                         ' 00:00:00.000Z');
//                 if (widget.selectedEvents[date] != null) {
//                   widget.selectedEvents[date]!.add(
//                     Event(
//                         when: when,
//                         where: where,
//                         category: category,
//                         id: ''),
//                   );
//                 } else {
//                   widget.selectedEvents[date] = [
//                     Event(
//                         when: when,
//                         where: where,
//                         category: category,
//                         id: '')
//                   ];
//                 }
//               }
//               Navigator.pop(context);
//               widget.setSchedule();
//               return;
//             },
//             child: Container(
//               child: Padding(
//                 padding: const EdgeInsets.all(15),
//                 child: Text(
//                   'Create WorkOut',
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 18),
//                 ),
//               ),
//               alignment: Alignment.center,
//               margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
//               width: width * 0.8,
//               decoration: BoxDecoration(
//                 color: LightColors.kBlue,
//                 borderRadius: BorderRadius.circular(30),
//               ),
//             ),
//           ))),
// )
