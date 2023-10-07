// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:async';
import 'package:flutter/material.dart';

class ChangingTextWidget extends StatefulWidget {
  final List<String> textList = [
    "Fetching crocodiles",
    "Generating PDF",
    "Talking with the AI",
    "Listening for sentience"
  ];

  ChangingTextWidget();

  @override
  _ChangingTextWidgetState createState() => _ChangingTextWidgetState();
}

class _ChangingTextWidgetState extends State<ChangingTextWidget> {
  int _currentIndex = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.textList.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.textList[_currentIndex],
      style: const TextStyle(
          fontSize: 18, color: Colors.black38, fontWeight: FontWeight.bold),
    );
  }
}
