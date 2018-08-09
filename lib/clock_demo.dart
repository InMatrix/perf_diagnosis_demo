import 'dart:async';

import 'package:flutter/material.dart';

class ClockDemo extends StatefulWidget {
  @override
  _ClockDemoState createState() => _ClockDemoState();
}

class _ClockDemoState extends State<ClockDemo> {
  var currentTime = DateTime.now();
  var timer;

  @override
  void initState() {
    timer = new Timer.periodic(new Duration(milliseconds: 1000), timerCallBack);
    super.initState();
  }

  void timerCallBack(Timer) {
    setState(() {
      currentTime = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Clock Demo"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          makeClock("Local", currentTime.timeZoneOffset.inHours),
          makeClock("UTC", 0),
          makeClock("New York, NY", -4),
          makeClock("Chicago, IL", -5),
          makeClock("Denver, CO", -6),
          makeClock("Los Angeles, CA", -7),
        ],
      ),
    );
  }

  Widget makeClock(String label, num utcOffset) {
    return ListTile(
      leading: Icon(Icons.watch),
      title: Text(label),
      subtitle: Text(
        currentTime.toUtc().add(Duration(hours: utcOffset)).toIso8601String(),
      ),
    );
  }
}
