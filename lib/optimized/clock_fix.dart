import 'dart:async';

import 'package:flutter/material.dart';

class ClockFix extends StatefulWidget {
  @override
  _ClockDemoState createState() => _ClockDemoState();
}

class _ClockDemoState extends State<ClockFix> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("World Clock Optimized"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          makeClock("Local", DateTime.now().timeZoneOffset.inHours),
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
      subtitle: ClockText(utcOffset: utcOffset),
    );
  }
}

class ClockText extends StatefulWidget {
  ClockText({
    Key key,
    this.utcOffset: 0,
  }) : super(key: key);

  final num utcOffset;

  @override
  _ClockTextState createState() => _ClockTextState();
}

class _ClockTextState extends State<ClockText> {
  var currentTime = DateTime.now();
  Timer timer;

  @override
  void initState() {
    timer = new Timer.periodic(new Duration(milliseconds: 1000 ~/ 60), timerCallBack);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  void timerCallBack(timer) {
    setState(() {
      currentTime = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      currentTime
          .toUtc()
          .add(Duration(hours: widget.utcOffset))
          .toIso8601String(),
    );
  }
}
