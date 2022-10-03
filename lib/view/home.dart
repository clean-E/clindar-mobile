import 'package:clindar_mobile/event.dart';
import 'package:clindar_mobile/graphQL/query_mutation.dart';
import 'package:clindar_mobile/theme/light_colors.dart';
import 'package:clindar_mobile/view/workOut/add_workout.dart';
import 'package:clindar_mobile/widget/bar/btmBar.dart';
import 'package:clindar_mobile/widget/calendar_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:provider/provider.dart';

import '../provider/google_sign_in.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key, required this.userInfo, required this.mySchedules})
      : super(key: key);
  Map userInfo;
  List mySchedules;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Map<DateTime, List<Event>> selectedSchedules = {};
  late DateTime selectedDay = DateTime.now();
  late DateTime focusedDay = DateTime.now();

  @override
  void initState() {
    for (var schedule in widget.mySchedules) {
      DateTime date =
          DateTime.parse(schedule['when'].substring(0, 10) + ' 00:00:00.000Z');

      if (selectedSchedules[date] != null) {
        selectedSchedules[date]!.add(
          Event(
              when: DateTime.parse(schedule['when']),
              where: schedule['where'],
              category: schedule['category'],
              id: schedule['_id']),
        );
      } else {
        selectedSchedules[date] = [
          Event(
              when: DateTime.parse(schedule['when']),
              where: schedule['where'],
              category: schedule['category'],
              id: schedule['_id'])
        ];
      }
    }
    // print('selectedSchedules: ${selectedSchedules}');
    super.initState();
  }

  List _getEventsfromDay(DateTime date) {
    return selectedSchedules[date] ?? [];
    // ?? : 왼쪽 표현식 값이 null이 아니면 왼쪽 표현식, null이면 오른쪽 표현식 return
  }

  void setSelectedDay(DateTime selectDay, DateTime focusDay) {
    setState(() {
      selectedDay = selectDay;
      focusedDay = focusDay;
    });
  }

  void setSchedule() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    return Scaffold(
      body: Container(
          alignment: Alignment.center,
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Calandar(
                  mySchedule: widget.mySchedules,
                  selectedDay: selectedDay,
                  focusedDay: focusedDay,
                  setSelectedDay: setSelectedDay,
                  selectedEvents: selectedSchedules,
                ),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AddWorkOut(
                        selectedDay: selectedDay,
                        userInfo: widget.userInfo,
                        selectedEvents: selectedSchedules,
                        setSchedule: setSchedule,
                      )));
        },
        label: Text("Add WorkOut"),
        icon: Icon(Icons.add),
        backgroundColor: LightColors.kBlue,
      ),
    );
  }
}
