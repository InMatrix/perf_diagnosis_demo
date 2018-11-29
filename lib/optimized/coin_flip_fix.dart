import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'dart:math';

final Random random = Random();
final NumberFormat formatter = NumberFormat.percentPattern('en_US');

class CoinFlipFix extends StatefulWidget {
  @override
  CoinFlipFixState createState() => CoinFlipFixState();
}

class CoinFlipFixState extends State<CoinFlipFix> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _flipAnimation;
  SchedulerBinding _scheduler;

  // The total number of tasks we will run. We need to split up the computational
  // work of calculating coin flips into multiple tasks. Each task should complete
  // in <= 4ms. This will prevent UI jank and dropped frames from occurring due
  // to a blocked UI thread.
  static final int _totalTasks = 50;
  // The current running task number. Will be in the range of 1 to [_totalTasks]
  // (inclusive).
  int _taskNumber = 1;

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
      assert(_taskNumber == 1);
      _headsCount = 0;
      _tailsCount = 0;
      _totalFlipCount = 250000;
      isCoinFlipping = true;

      _maybeScheduleTask();
    }
  }

  void _maybeScheduleTask() {
    if (_taskNumber <= _totalTasks) {
      // For each task, do a small chunk of work that will complete in <= 4ms:
      // _totalFlipCount / _totalTasks = 5000 flips per task.
      _scheduler.scheduleTask(() => _flipNTimes(5000), Priority.animation);
    } else {
      // At this point, all of the tasks have been completed. Update the UI.
      setState(() {
        _taskNumber = 1;
        isCoinFlipping = false;
      });
    }
  }

  void _flipNTimes(int n) {
    for (int i = 0; i < n; i++) {
      bool isHeads = random.nextInt(2) % 2 == 0;
      if (isHeads) {
        _headsCount++;
      } else {
        _tailsCount++;
      }
    }
    _taskNumber++;
    _maybeScheduleTask();
  }

  @override
  void initState() {
    super.initState();
    _scheduler = SchedulerBinding.instance;
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
