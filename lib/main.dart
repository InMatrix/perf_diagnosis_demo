import 'package:flutter/material.dart';

import 'opacity_animation_demo.dart';
import 'opacity_demo.dart';

void main() => runApp(new MyApp());

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
        new PerformanceOverlay.allEnabled(
          checkerboardOffscreenLayers: true,
        ),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            makeDemoEntry(context, "Opacity Demo 1", OpacityDemo1()),
            makeDemoEntry(context, "Opacity Demo 2", OpacityDemo2()),
            makeDemoEntry(
                context, "Opacity Animation Demo", OpacityAnimationDemo1()),
          ],
        ),
      ),
    );
  }

  Widget makeDemoEntry(BuildContext context, String title, Widget nextScreen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
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
