import 'package:flutter/foundation.dart';

class Event {
  final String where;
  final DateTime when;
  final List category;
  final String id;
  Event(
      {required this.when,
      required this.category,
      required this.where,
      required this.id});

  @override
  String toString() => this.where;
}
