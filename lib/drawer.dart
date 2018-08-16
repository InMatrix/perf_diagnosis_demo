import 'package:flutter/material.dart';

import 'animate_opacity_fix.dart';
import 'animated_builder_fix.dart';
import 'clock_fix.dart';
import 'many_materials_demo.dart';
import 'opacity_demo.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 100.0,
            child: Center(
              child: new Text(
                'Optimized Examples',
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 1.5),
              ),
            ),
          ),
          _makeDemoEntry(context, "World Clock Demo", ClockFix()),
          _makeDemoEntry(context, "Spinning Boxes Demo", AnimatedBuilderFix()),
          _makeDemoEntry(context, "Score Card Demo", AnimateOpacityFix()),
          Divider(),
          new Text(
            'More Examples',
            style:
                DefaultTextStyle.of(context).style.apply(fontSizeFactor: 1.5),
          ),
          _makeDemoEntry(context, "Many Materials Demo", ManyMaterialsDemo()),
          _makeDemoEntry(context, "Opacity Demo", OpacityDemo1()),
        ],
      ),
    );
  }

  Widget _makeDemoEntry(BuildContext context, String title, Widget nextScreen) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          width: 50.0,
        ),
        Icon(Icons.star),
        FlatButton(
          child: Text(title),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => nextScreen),
            );
          },
        ),
      ],
    );
  }
}
