// This demo shows that passing in non-animated widgets as a child into an
// AnimatedBuilder can avoid them to be rebuilt in every frame.

import 'package:flutter/material.dart';

import '../color_list.dart';
import 'dart:math';

class SpinningBoxFix extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Spinning Box Optimized"),
      ),
      body: Center(
        child: new GridView.count(
          primary: false,
          padding: const EdgeInsets.all(20.0),
          mainAxisSpacing: 30.0,
          crossAxisSpacing: 30.0,
          crossAxisCount: 3,
          children: new List<Widget>.generate(12, (i) => GridItem()),
        ),
      ),
    );
  }
}

// Widget for the box with a grid in it
class GridItem extends StatefulWidget {
  @override
  _GridItemState createState() => _GridItemState();
}

class _GridItemState extends State<GridItem> with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this);
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
        child: GridInGrid(),
      ),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

// Widget that makes its content spinnable
class SpinningBox extends StatelessWidget {
  SpinningBox({this.child, required this.animation});

  final Widget? child;
  final Animation<double> animation;

  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          return Transform.rotate(
            angle: animation.value,
            child: child,
          );
        },
        child: child);
  }
}

class GridInGrid extends StatelessWidget {
  final colorList = getColorList();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView.count(
        primary: false,
        crossAxisCount: 3,
        children: new List<Widget>.generate(
          9,
          (i) => Container(
            color: colorList[i],
          ),
        ),
      ),
    );
  }
}
