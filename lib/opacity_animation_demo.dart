// This demo directly animate the opacity property on the Opacity widget
// to change the opacity of each cell in the grid. It's supposed to be slower
// than using AnimatedOpacity or FadeTransition

import 'package:flutter/material.dart';
import 'package:random_pk/random_pk.dart';

class OpacityAnimationDemo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Opacity Animation Demo 1"),
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
    animation = Tween(begin: 1.0, end: 0.0).animate(curve)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) controller.reverse();
      });
//    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.forward();
      },
      child: OpacityChanges(
        child: RandomContainer(
          child: GridView.count(
            primary: false,
//            padding: const EdgeInsets.all(20.0),
//            mainAxisSpacing: 10.0,
//            crossAxisSpacing: 10.0,
            crossAxisCount: 3,
            children: new List<Widget>.generate(9, (i) => RandomContainer()),
          ),
        ),
        animation: animation,
      ),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

class OpacityChanges extends StatelessWidget {
  OpacityChanges({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget child) {
          return Opacity(
            opacity: animation.value,
            child: child,
          );
        },
        child: child);
  }
}
