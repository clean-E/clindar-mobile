// import 'dart:html';

import 'dart:collection';
import 'dart:ffi';

import 'package:clindar_mobile/event.dart';
import 'package:clindar_mobile/graphQL/query_mutation.dart';
import 'package:clindar_mobile/theme/light_colors.dart';
import 'package:clindar_mobile/view/schedule_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/date_symbol_data_local.dart';

class Calandar extends StatefulWidget {
  Calandar(
      {Key? key,
      required this.mySchedule,
      required this.setSelectedDay,
      required this.focusedDay,
      required this.selectedDay,
      required this.selectedEvents})
      : super(key: key);
  List mySchedule;
  final Function setSelectedDay;
  DateTime selectedDay;
  DateTime focusedDay;
  late Map<DateTime, List<Event>> selectedEvents;

  @override
  State<Calandar> createState() => _CalandarState();
}

class _CalandarState extends State<Calandar> {
  CalendarFormat format = CalendarFormat.month;

  @override
  void initState() {
    super.initState();
  }

  void setCalendar() {
    setState(() {});
  }

  void deleteSchedule(DateTime selectedDay, String id) {
    List<Event>? scheduleList = widget.selectedEvents[selectedDay];
    int delScheduleNum = 0;
    bool flag = false;
    for (int i = 0; i <= scheduleList!.length; i++) {
      if (scheduleList[i].id == id) {
        delScheduleNum = i;
        flag = true;
        break;
      }
    }
    if (flag == true) {
      scheduleList.removeAt(delScheduleNum);
    }
  }

  List<Event> _getEventsfromDay(DateTime date) {
    final events = LinkedHashMap(
      equals: isSameDay,
    )..addAll(widget.selectedEvents);
    return events[date] ?? [];
    // ?? : 왼쪽 표현식 값이 null이 아니면 왼쪽 표현식, null이면 오른쪽 표현식 return
  }

  @override
  Widget build(BuildContext context) {
    print('widget.selectedEvents : ${widget.selectedEvents}');
    return Column(
      children: [
        TableCalendar(
          focusedDay: widget.focusedDay,
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          daysOfWeekHeight: 30,
          headerStyle: HeaderStyle(
            headerMargin:
                EdgeInsets.only(left: 40, top: 10, right: 40, bottom: 10),
            titleCentered: true,
            formatButtonVisible: false,
            leftChevronIcon: Icon(Icons.arrow_left),
            rightChevronIcon: Icon(Icons.arrow_right),
            titleTextStyle: const TextStyle(fontSize: 17.0),
          ),
          calendarBuilders: CalendarBuilders(
            markerBuilder: (context, day, events) {},
          ),
          calendarStyle: CalendarStyle(
            isTodayHighlighted: true,
            selectedDecoration: BoxDecoration(
                color: LightColors.kGreen, shape: BoxShape.circle),
            selectedTextStyle: TextStyle(color: Colors.white),
            outsideDaysVisible: true,
            weekendTextStyle: TextStyle().copyWith(color: Colors.red),
            holidayTextStyle: TextStyle().copyWith(color: Colors.blue[800]),
          ),
          locale: 'ko-KR',
          eventLoader: _getEventsfromDay,

          // Day Changed
          onDaySelected: (selectDay, focusDay) {
            widget.setSelectedDay(selectDay, focusDay);
          },
          selectedDayPredicate: (day) {
            return isSameDay(widget.selectedDay, day);
          },
        ),
        ..._getEventsfromDay(widget.selectedDay).map((event) => Query(
            options: QueryOptions(
                document: gql(QueryAndMutation.getScheduleDetail),
                variables: {
                  'schedule': {'_id': event.id}
                }),
            builder: ((result, {fetchMore, refetch}) {
              return ListTile(
                  title: Text(event.where),
                  subtitle: Text(event.when.toString().substring(0, 19)),
                  onTap: () {
                    // print('getScheduleDetail : ${event.id}');
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScheduleDetail(
                                deleteSchedule: deleteSchedule,
                                setCalendar: setCalendar,
                                scheduleDetail:
                                    result.data!['getScheduleDetail'])));
                  });
            }))),
      ],
    );
  }
}
