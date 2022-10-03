import 'package:clindar_mobile/data/level.dart';
import 'package:clindar_mobile/graphQL/query_mutation.dart';
import 'package:clindar_mobile/theme/light_colors.dart';
import 'package:clindar_mobile/widget/btn/back_button.dart';
import 'package:clindar_mobile/widget/field/txt_field.dart';
import 'package:clindar_mobile/widget/record/workOut_record.dart';
import 'package:clindar_mobile/widget/text_plus_icon.dart';
import 'package:clindar_mobile/widget/top_container.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class ScheduleDetail extends StatefulWidget {
  ScheduleDetail(
      {Key? key,
      required this.scheduleDetail,
      required this.setCalendar,
      required this.deleteSchedule})
      : super(key: key);
  late var scheduleDetail;
  Function setCalendar;
  Function deleteSchedule;

  @override
  State<ScheduleDetail> createState() => _ScheduleDetailState();
}

class _ScheduleDetailState extends State<ScheduleDetail> {
  TextEditingController _purpleController = TextEditingController();
  TextEditingController _redController = TextEditingController();
  TextEditingController _blueController = TextEditingController();
  TextEditingController _greenController = TextEditingController();
  TextEditingController _orangeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    print(widget.scheduleDetail);
    int guestCount = widget.scheduleDetail['who']['guest'].length;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final user = FirebaseAuth.instance.currentUser!;
    List category = widget.scheduleDetail['category'];
    List level = (category[0] == '리드')
        ? leadLevel
        : (category[1] == '실내')
            ? bolderIndoorLevel
            : bolderOutdoorLevel;
    print(level);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        children: [
          Expanded(
            child: TopContainer(
                padding: EdgeInsets.fromLTRB(16, 20, 16, 30),
                width: width,
                height: height * 0.4,
                child: Column(children: [
                  MyBackButton(data: "WorkOut Detail"),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        Row(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 8, 3),
                            child: Icon(Icons.place),
                          ),
                          Text(widget.scheduleDetail['where'])
                        ]),
                        Row(children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 8, 3),
                            child: Icon(Icons.access_time),
                          ),
                          Text(widget.scheduleDetail['when'].substring(0, 19))
                        ]),
                        Visibility(
                          visible: (widget.scheduleDetail['memo'] == "")
                              ? false
                              : true,
                          child: Row(children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 8, 3),
                              child: Icon(Icons.note_alt),
                            ),
                            Text(widget.scheduleDetail['memo'])
                          ]),
                        ),
                        Visibility(
                          visible: (widget.scheduleDetail['group'] == "")
                              ? false
                              : true,
                          child: Row(children: [
                            Padding(
                              padding: const EdgeInsets.fromLTRB(0, 0, 8, 3),
                              child: Icon(Icons.note_alt),
                            ),
                            Text(widget.scheduleDetail['group'])
                          ]),
                        )
                      ],
                    ),
                  ),
                ])),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 15, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Mutation(
                    options: MutationOptions(
                      document: gql(QueryAndMutation.deleteSchedule),
                      update: ((cache, result) {}),
                      onCompleted: (data) {
                        print('Schedule delete Success');
                      },
                      onError: (error) {
                        print('SD error:${error}');
                      },
                    ),
                    builder: ((runMutation, result) => TextButton.icon(
                        onPressed: () {
                          runMutation({
                            'schedule': {
                              'email': user.email,
                              '_id': widget.scheduleDetail['_id']
                            }
                          });
                          DateTime date = DateTime.parse(
                              widget.scheduleDetail['when'].substring(0, 10) +
                                  ' 00:00:00.000Z');
                          widget.deleteSchedule(
                              date, widget.scheduleDetail['_id']);
                          widget.setCalendar();
                          Navigator.pop(context);
                          return;
                        },
                        icon: Icon(Icons.delete),
                        label: Text('delete')))),
                Mutation(
                    options: MutationOptions(
                      document: gql(QueryAndMutation.editSchedule),
                      update: ((cache, result) {}),
                      onCompleted: (data) {
                        print('Schedule edit Success');
                      },
                      onError: (error) {
                        print('SD error:${error}');
                      },
                    ),
                    builder: ((runMutation, result) => TextButton.icon(
                        onPressed: () {
                          runMutation({
                            'schedule': {
                              'email': user.email,
                              '_id': widget.scheduleDetail['_id']
                            }
                          });

                          //             Navigator.push(
                          // context,
                          // MaterialPageRoute(
                          //     builder: (context) => AddWorkOut(
                          //           selectedDay: selectedDay,
                          //           userInfo: widget.userInfo,
                          //           selectedEvents: selectedSchedules,
                          //           setSchedule: setSchedule,
                          //         )));
                          return;
                        },
                        icon: Icon(Icons.edit),
                        label: Text('edit')))),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: ListView.builder(
                itemCount: guestCount,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                    child: Column(
                      children: [
                        Text('Guest List'),
                        ListTile(
                          onTap: (() {
                            showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                      title: Text('Add Record'),
                                      content: Column(
                                        children: [
                                          WorkOutRecord(category: category),
                                          NumberInputPrefabbed.roundedButtons(
                                            controller: TextEditingController(),
                                            min: 0,
                                            max: 50,
                                            incDecBgColor: LightColors.kBlue,
                                            // widgetContainerDecoration: BoxDecoration(border: ),
                                            onSubmitted: (newValue) {},
                                          ),
                                          WorkOutRecord(category: category),
                                          NumberInputWithIncrementDecrement(
                                            controller: TextEditingController(),
                                            min: 0,
                                            max: 50,
                                          ),
                                        ],
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: Text("cancel"),
                                        ),
                                        TextButton(
                                            onPressed: () {
                                              // if (_recordController
                                              //     .text.isEmpty) {
                                              // } else {
                                              //   widget.scheduleDetail['who']
                                              //           ['guest']['index']
                                              //           ['redord']['level']
                                              //       .add(
                                              //           _recordController.text);
                                              // }
                                              Navigator.pop(context);

                                              setState(() {});
                                              return;
                                            },
                                            child: Text('Add'))
                                      ],
                                    ));
                          }),
                          title: Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 0, 20, 0),
                                child: Text(widget.scheduleDetail['who']
                                    ['guest'][index]['nickname']),
                              ),
                              Icon(
                                Icons.circle,
                                color: Colors.purple,
                              ),
                              Text('1'),
                              Icon(
                                Icons.circle,
                                color: Colors.red,
                              ),
                              Text('1'),
                              Icon(
                                Icons.circle,
                                color: Colors.blue,
                              ),
                              Text('1'),
                              Icon(
                                Icons.circle,
                                color: Colors.green,
                              ),
                              Text('1'),
                            ],
                          ),
                          subtitle: Visibility(
                              visible: widget.scheduleDetail['who']['guest']
                                          [index]['nickname'] ==
                                      widget.scheduleDetail['who']['host']
                                  ? true
                                  : false,
                              child: Row(
                                children: [
                                  // Icon(Icons.star_border),
                                  Text('Host'),
                                ],
                              )),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}
