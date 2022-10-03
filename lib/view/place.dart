import 'package:flutter/material.dart';

class Place extends StatefulWidget {
  const Place({Key? key}) : super(key: key);

  @override
  State<Place> createState() => _PlaceState();
}

class _PlaceState extends State<Place> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Text('Place')),
    );
  }
}
