import 'package:flutter/material.dart';

// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

class AgreementScreen extends StatelessWidget {
  AgreementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: const Text("My Agreements",
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
        ),
      ]),
    );
  }
}
