import 'package:flutter/material.dart';
import 'package:random_pk/random_pk.dart';

class OpacityDemo extends StatelessWidget {
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

Widget createItem(index) {
  return RandomContainer(
    child: Text(index.toString()),
  );
}
