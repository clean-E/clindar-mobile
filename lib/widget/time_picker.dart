import 'package:clindar_mobile/view/workOut/add_workout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimePicker extends StatefulWidget {
  const TimePicker(
      {Key? key, required this.setDateTime, required this.selectedTime})
      : super(key: key);
  final Function setDateTime;
  final DateTime selectedTime;

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  @override
  void initState() {
    widget.setDateTime(widget.selectedTime);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        height: height * 0.18,
        child: CupertinoTheme(
          data: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
                dateTimePickerTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
          ),
          child: CupertinoDatePicker(
              use24hFormat: false,
              initialDateTime: widget.selectedTime,
              onDateTimeChanged: (dateTime) {
                widget.setDateTime(dateTime);
              }),
        ));
  }
}
