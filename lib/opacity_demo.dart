import 'package:flutter/material.dart';
import 'package:random_pk/random_pk.dart';

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

  Widget createItem(index) {
    return RandomContainer(
      child: Text(index.toString()),
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

  Widget createItem(index) {
    return Opacity(
      opacity: 0.5,
      child: RandomContainer(
        child: Text(index.toString()),
      ),
    );
  }
}
