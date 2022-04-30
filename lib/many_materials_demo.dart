

import 'package:flutter/material.dart';

import 'color_list.dart';

class ManyMaterialsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Many Materials Demo"),
      ),
      body: Center(
        child: Card(
          color: Colors.grey[50],
          child: new GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20.0),
            mainAxisSpacing: 10.0,
            crossAxisSpacing: 10.0,
            crossAxisCount: 3,
            children: new List<Widget>.generate(12, (i) => GridItem()),
          ),
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
  Animation? animation;
  late AnimationController controller;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);
    final CurvedAnimation curve =
        CurvedAnimation(parent: controller, curve: Curves.easeOut);
    animation = Tween(begin: 0.0, end: 10.0).animate(curve)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) controller.reverse();
      });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.forward();
      },
      child: PaddingAnimation(
        animation: animation as Animation<double>?,
        child: GridInGrid(),
      ),
    );
  }

  dispose() {
    controller.dispose();
    super.dispose();
  }
}

class PaddingAnimation extends StatelessWidget {
  PaddingAnimation({this.child, this.animation});

  final Widget? child;
  final Animation<double>? animation;

  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: animation!,
        builder: (BuildContext context, Widget? child) {
          return Padding(
            padding: EdgeInsets.all(animation!.value),
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
    return Material(
      elevation: 3.0,
      child: Container(
        child: GridView.count(
          primary: false,
          crossAxisCount: 3,
          children: new List<Widget>.generate(
            9,
            (i) => Material(
                  elevation: 3.0,
                  child: Container(
                    color: colorList[i],
                  ),
                ),
          ),
        ),
      ),
    );
  }
}
