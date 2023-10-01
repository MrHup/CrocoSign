import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // add a container in the center of the screen

    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Lottie.asset('assets/lottie.json'),
        ));
  }
}