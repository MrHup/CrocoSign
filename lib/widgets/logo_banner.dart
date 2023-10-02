import 'package:crocosign/static/globals.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LogoBanner extends StatelessWidget {
  LogoBanner(this.title, {super.key});
  String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text(title,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Globals.secondaryColor)),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Image(
              image: AssetImage('assets/logo.png'),
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
