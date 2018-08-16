import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'animate_opacity_demo.dart';
import 'animated_builder_demo.dart';
import 'clock_demo.dart';
import 'drawer.dart';
import 'list_demo.dart';

void main() {
  debugProfileBuildsEnabled = true; // This flag will work in debug mode only.
//  debugProfilePaintsEnabled = true;
  debugPrintRebuildDirtyWidgets = false;
  // This flag will print out all dirty widgets
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        new MaterialApp(
          title: 'Flutter Demo',
          theme: new ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: new MyHomePage(title: 'Flutter Perf Diagnosis Demo'),
        ),
//        new PerformanceOverlay.allEnabled(
//          checkerboardOffscreenLayers: true,
//        ),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      drawer: MyDrawer(),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            makeDemoEntry(context, "Clock Demo", ClockDemo()),
            makeDemoEntry(context, "List Demo", ListDemo()),
            makeDemoEntry(
                context, "Spinning Boxes Demo", AnimatedBuilderDemo()),
            makeDemoEntry(context, "Score Card Demo", AnimateOpacityDemo()),
          ],
        ),
      ),
    );
  }

  Widget makeDemoEntry(BuildContext context, String title, Widget nextScreen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 50.0,
        ),
        Icon(Icons.star),
        FlatButton(
          child: Text(title),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => nextScreen),
            );
          },
        ),
      ],
    );
  }
}
