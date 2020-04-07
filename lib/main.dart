import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'clock_demo.dart';
import 'drawer.dart';
import 'coin_flip_demo.dart';
import 'list_demo.dart';
import 'scorecard_demo.dart';
import 'spinning_box_demo.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Performance Diagnosis Demo'),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SectionHeader(
                  title: "Rendering Performance",
                ),
                makeDemoEntry(context, "World Clock Demo", ClockDemo()),
                makeDemoEntry(context, "List Demo", ListDemo()),
                makeDemoEntry(
                    context, "Spinning Boxes Demo", SpinningBoxDemo()),
                makeDemoEntry(context, "Scorecard Demo", ScorecardDemo()),
              ],
            ),
          ),
          Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SectionHeader(
                    title: "CPU Performance",
                  ),
                  makeDemoEntry(context, "Coin Flip Demo", CoinFlipDemo()),
            ],
          ))
        ],
      ),
    );
  }

  Widget makeDemoEntry(BuildContext context, String title, Widget nextScreen) {
    return Row(
      children: <Widget>[
        SizedBox(
          width: 50.0,
        ),
        Icon(Icons.warning),
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

class SectionHeader extends StatelessWidget {
  SectionHeader({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text(
        title,
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
