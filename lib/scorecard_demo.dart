import 'package:flutter/material.dart';
import 'color_list.dart';

class ScorecardDemo extends StatefulWidget {
  @override
  _ScorecardDemoState createState() {
    return new _ScorecardDemoState();
  }
}

class _ScorecardDemoState extends State<ScorecardDemo>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  bool scoreVisible = false;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    animation = Tween(begin: 1.0, end: 0.3).animate(controller)
      ..addListener(() {
        setState(() {});
      });

    super.initState();
  }

  void showScore() {
    setState(() {
      scoreVisible = true;
    });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Animated Opacity Demo"),
      ),
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: dismissScore,
            child: Opacity(
              opacity: animation.value,
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
                    child: ElevatedButton(
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
    var colorList = getColorList();

    if (index >= 9) {
      index = index - 9;
    }
    return Container(
      color: colorList[index],
    );
  }

  void dismissScore() {
    if (scoreVisible) {
      controller.reverse();
      setState(() {
        scoreVisible = false;
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
