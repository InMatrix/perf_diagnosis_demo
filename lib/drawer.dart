import 'package:flutter/material.dart';
import 'optimized/spinning_box_fix.dart';
import 'many_materials_demo.dart';
import 'opacity_demo.dart';
import 'optimized/clock_fix.dart';
import 'optimized/coin_flip_fix.dart';
import 'optimized/list_fix.dart';
import 'optimized/scorecard_fix.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: new Text(
                'Optimized Examples',
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 1.5),
              ),
            ),
          ),
          _makeDemoEntry(context, "World Clock Demo", ClockFix()),
          _makeDemoEntry(context, "List Demo", ListFix()),
          _makeDemoEntry(context, "Spinning Box Demo", SpinningBoxFix()),
          _makeDemoEntry(context, "Scorecard Demo", ScorecardFix()),
          _makeDemoEntry(context, "Coin Flip Demo", CoinFlipFix()),
          Divider(),
          Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: new Text(
                'More Examples',
                style: DefaultTextStyle.of(context)
                    .style
                    .apply(fontSizeFactor: 1.5),
              ),
            ),
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
        TextButton(
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
