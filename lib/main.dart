import 'dart:async';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyTimerApp(),
    );
  }
}

class MyTimerApp extends StatefulWidget {
  @override
  _MyTimerAppState createState() => _MyTimerAppState();
}

class _MyTimerAppState extends State<MyTimerApp> {
  late DateTime _currentTime;
  late Stopwatch _stopwatch;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _currentTime = DateTime.now();
    _stopwatch = Stopwatch()..start();
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  void _resetTimer() {
    setState(() {
      _stopwatch.reset();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '現在時間: ${_currentTime.hour}:${_currentTime.minute}:${_currentTime.second}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              '計時: ${_formatTime(_stopwatch.elapsed)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                if (_stopwatch.isRunning) {
                  _stopwatch.stop();
                } else {
                  _stopwatch.start();
                }
              });
            },
            child: Icon(_stopwatch.isRunning ? Icons.pause : Icons.play_arrow),
          ),
          FloatingActionButton(
            onPressed: _resetTimer,
            child: Icon(Icons.refresh),
          ),
        ],
      ),
    );
  }
}