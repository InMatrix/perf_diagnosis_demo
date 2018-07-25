// This demo show animating the Opacity widget directly can cause all its
// sub-tree to rebuild in every frame of the animation.

import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:random_pk/random_pk.dart';

class AnimateOpacityDemo extends StatefulWidget {
  @override
  AnimateOpacityDemoState createState() {
    return new AnimateOpacityDemoState();
  }
}

class AnimateOpacityDemoState extends State<AnimateOpacityDemo>
    with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;
  bool scoreVisible = false;

  @override
  void initState() {
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    animation = Tween(begin: 1.0, end: 0.3).animate(controller)
    ..addListener((){
      setState(() {
        scoreVisible = true;
      });
    });

    super.initState();
  }

  void showScore() {
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
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

  Widget buildScoreOverlay(){
    if (scoreVisible){
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
    return RandomContainer(
      child: Text(index.toString()),
    );
  }

  void dismissScore() {
    if (scoreVisible) {
      scoreVisible = false;
      controller.reverse();
      setState(() {
      });
    }
  }
}
