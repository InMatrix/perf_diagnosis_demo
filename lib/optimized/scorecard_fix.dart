// This demo shows that using AnimatedOpacity instead of animating the Opacity
// widget directly can avoid rebuilding its sub-tree in every frame of the
// animation.

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

import '../color_list.dart';

class ScorecardFix extends StatefulWidget {
  @override
  ScorecardFixState createState() {
    return new ScorecardFixState();
  }
}

class ScorecardFixState extends State<ScorecardFix>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  var opacityVal = 1.0;
  bool scoreVisible = false;

  @override
  void initState() {
    super.initState();
  }

  void showScore() {
    setState(() {
      opacityVal = 0.3;
      scoreVisible = true;
    });
  }

  void dismissScore() {
    if (scoreVisible) {
      setState(() {
        opacityVal = 1.0;
        scoreVisible = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Scorecard Optimized"),
      ),
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: dismissScore,
            child: AnimatedOpacity(
              duration: Duration(milliseconds: 500),
              opacity: opacityVal,
              child: Column(
                children: <Widget>[
                  Flexible(
                    flex: 9,
                    child: new GridView.count(
                      primary: false,
                      padding: const EdgeInsets.all(20.0),
                      crossAxisSpacing: 10.0,
                      crossAxisCount: 3,
                      children: new List<Widget>.generate(15, createItem),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: RaisedButton(
                      onPressed: showScore,
                      child: Text("Show Score"),
                    ),
                  )
                ],
              ),
            ),
          ),
          buildScoreOverlay(),
        ],
      ),
    );
  }

  Widget buildScoreOverlay() {
    if (scoreVisible) {
      return Center(
        child: Text("Your Score is 100!"),
      );
    } else {
      return Placeholder(
        color: const Color(0xFFFFFF),
      );
    }
  }

  Widget createItem(index) {
    final colorList = getColorList();

    if (index >= 9) {
      index = index - 9;
    }
    return Container(
      color: colorList[index],
    );
  }
}
