import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class PencilProgressIndicator extends StatelessWidget {
  const PencilProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 90, height: 90, child: Lottie.asset('assets/pencil_croco.json'));
  }
}
