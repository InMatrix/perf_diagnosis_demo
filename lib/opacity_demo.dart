import 'package:flutter/material.dart';
import 'color_list.dart';

class OpacityDemo1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: Opacity(
          opacity: 0.5,
          child: new GridView.count(
            primary: false,
            padding: const EdgeInsets.all(20.0),
            crossAxisSpacing: 10.0,
            crossAxisCount: 3,
            children: new List<Widget>.generate(100, createItem),
          )),
    );
  }
}

class OpacityDemo2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Screen"),
      ),
      body: new GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20.0),
        crossAxisSpacing: 10.0,
        crossAxisCount: 3,
        children: new List<Widget>.generate(100, createItem),
      ),
    );
  }
}

Widget createItem(index) {
  final colorList = getColorList();

  while (index >= 9) {
    index = index - 9;
  }

  return Opacity(
    opacity: 0.5,
    child: Container(
      color: colorList[index],
    ),
  );
}
