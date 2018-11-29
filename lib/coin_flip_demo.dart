import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

final Random random = Random();
final NumberFormat formatter = NumberFormat.percentPattern('en_US');

class CoinFlipDemo extends StatefulWidget {
  @override
  CoinFlipDemoState createState() => CoinFlipDemoState();
}

class CoinFlipDemoState extends State<CoinFlipDemo> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _flipAnimation;

  // Whether the coin is currently flipping
  bool isCoinFlipping = false;
  // The number of times the coin flip resulted in heads.
  int _headsCount = 0;
  // The number of times the coin flip resulted in tails.
  int _tailsCount = 0;
  // The total number of times the coin has been flipped.
  int _totalFlipCount = 0;

  void _flipCoin() {
    if (!isCoinFlipping) {
      _headsCount = 0;
      _tailsCount = 0;
      _totalFlipCount = 250000;

      setState(() {
        isCoinFlipping = true;
        for (int i = 0; i < _totalFlipCount; i++) {
          bool isHeads = random.nextInt(2) % 2 == 0;
          if (isHeads) {
            _headsCount++;
          } else {
            _tailsCount++;
          }
        }
        isCoinFlipping = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 800), vsync: this);
    final CurvedAnimation curve = CurvedAnimation(
        parent: _controller,
        curve: Interval(0.0, 1.0, curve: Curves.linear)
    );
    _flipAnimation = Tween(begin: 0.0, end: 1.0).animate(curve);
    _controller.repeat();
  }

  dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Coin Flip Demo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Column(
              children: <Widget>[
                _Coin(controller: _controller, flipAnimation: _flipAnimation),
                SizedBox(height: 10.0),
                _FlipButton(onPressed: _flipCoin)
              ],
            ),
            _Results(heads: _headsCount, tails: _tailsCount, total: _totalFlipCount),
          ],
        ),
      ),
    );
  }
}

class _Coin extends StatelessWidget {
  _Coin({this.controller, this.flipAnimation});

  final AnimationController controller;
  final Animation flipAnimation;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: AnimatedBuilder(
        animation: controller,
        builder: (BuildContext context, Widget child) {
          return Center(
            child: Container(
              height: 150.0,
              width: 150.0,
              child: Transform(
                transform: Matrix4.identity()
                  ..rotateX(2 * pi * flipAnimation.value),
                alignment: Alignment.center,
                child: ClipOval(
                    child: Container(
                      color: Colors.amber,
                    )
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _FlipButton extends StatelessWidget {
  _FlipButton({this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text(
        'Flip Coin',
        style: TextStyle(
          fontSize: 24.0,
        ),
      ),
      textColor: Colors.white,
      color: Colors.blue,
      onPressed: onPressed,
    );
  }
}

class _Results extends StatelessWidget {
  _Results({this.heads, this.tails, this.total});

  final int heads;
  final int tails;
  final int total;
  
  String get headsPercentage => total == 0 ? '-- %' : formatter.format(heads / total);
  String get tailsPercentage => total == 0 ? '-- %' : formatter.format(tails / total);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomCenter,
        child: Column(
          children: <Widget>[
            Text(
              'Results',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 10.0),
            Text(
              'Heads: $heads',
              style: Theme.of(context).textTheme.headline,
            ),
            SizedBox(height: 10.0),
            Text(
              'Tails: $tails',
              style: Theme.of(context).textTheme.headline
            ),
            SizedBox(height: 10.0),
            Text(
              'Total flips: $total',
              style: Theme.of(context).textTheme.headline,
            ),
            SizedBox(height: 10.0),
            Text(
              'The coin lands on Heads ~$headsPercentage of the time.',
              style: Theme.of(context).textTheme.title,
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.0),
            Text(
              'The coin lands on Tails ~$tailsPercentage of the time.',
              style: Theme.of(context).textTheme.title,
              textAlign: TextAlign.center,
            ),
          ],
        )
    );
  }
}
