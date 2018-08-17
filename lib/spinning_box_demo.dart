import 'dart:math';

import 'package:flutter/material.dart';

import 'color_list.dart';

class SpinningBoxDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spinning Box Demo"),
      ),
      body: Center(
        child: new GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20.0),
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          crossAxisCount: 3,
          children: new List<Widget>.generate(12, (i) => GridItem()),
        ),
      ),
    );
  }
}

class GridItem extends StatefulWidget {
  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> with TickerProviderStateMixin {
  Animation animation;
  AnimationController controller;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.easeOut);
    animation = Tween(begin: 0.0, end: pi * 2).animate(curve)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) controller.reset();
      });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.forward();
      },
      child: SpinningBox(
        animation: animation,
      ),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

class SpinningBox extends StatelessWidget {
  SpinningBox({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;
  final colorList = getColorList();

  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget child) {
          return Transform.rotate(
            angle: animation.value,
            child: Padding(
              padding: EdgeInsets.all(5.0),
              child: Container(
                child: GridView.count(
                  primary: false,
                  crossAxisCount: 3,
                  children: new List<Widget>.generate(
                      9,
                      (i) => Container(
                            color: colorList[i],
                          )),
                ),
              ),
            ),
          );
        },
        child: child);
  }
}
