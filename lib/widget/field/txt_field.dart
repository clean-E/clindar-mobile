import 'package:clindar_mobile/view/workOut/add_workout.dart';
import 'package:flutter/material.dart';

class TxtField extends StatefulWidget {
  const TxtField({
    Key? key,
    required this.label,
    required this.maxLines,
    required this.minLines,
    required this.icon,
    required this.controller,
  }) : super(key: key);
  final String label;
  final int maxLines;
  final int minLines;
  final Icon icon;
  final TextEditingController controller;

  @override
  State<TxtField> createState() => _TxtFieldState();
}

class _TxtFieldState extends State<TxtField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(102, 201, 201, 201),
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: TextField(
          controller: widget.controller,
          style: TextStyle(color: Colors.black),
          minLines: widget.minLines,
          maxLines: widget.maxLines,
          decoration: InputDecoration(
              suffixIcon: widget.icon == null ? null : widget.icon,
              labelText: widget.label,
              labelStyle: TextStyle(color: Colors.black),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.black)),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey))),
        ),
      ),
    );
  }
}
