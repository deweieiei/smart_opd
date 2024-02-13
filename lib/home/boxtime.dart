import 'dart:async';

import 'package:flutter/material.dart';

class Box_Time extends StatefulWidget {
  const Box_Time({super.key});

  @override
  State<Box_Time> createState() => _Box_TimeState();
}

class _Box_TimeState extends State<Box_Time> {
  String time = '';
  DateTime dateTime = DateTime.parse('0000-00-00 00:00');
  Timer? timer;
  void start() {
    timer = Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        dateTime = DateTime.now();
        time = "${dateTime.day}/" +
            "${dateTime.month}/" +
            "${dateTime.year}, " +
            "${dateTime.hour}:" +
            "${dateTime.minute.toString().padLeft(2, '0')}:" +
            "${dateTime.second.toString().padLeft(2, '0')}";
      });
    });
  }

  @override
  void initState() {
    start();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    timer!.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    // double _width = MediaQuery.of(context).size.width;
    TextStyle style = TextStyle(
        color: Color.fromARGB(255, 135, 201, 255), fontSize: _height * 0.03);
    return Text(time, style: style);
  }
}
