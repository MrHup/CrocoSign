import 'package:crocosign/static/globals.dart';
import 'package:crocosign/widgets/card_agreement.dart';
import 'package:crocosign/widgets/logo_banner.dart';
import 'package:flutter/material.dart';

// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

class AgreementScreen extends StatelessWidget {
  AgreementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Globals.backgroundColor,
        body: Column(children: [
          LogoBanner("My Agreements"),
          Container(
            child: Expanded(
              child: ListView(
                children: [
                  CardAgreement(
                      title: "THIS IS A TEST",
                      status: "waiting",
                      date: "22-03-2019"),
                  CardAgreement(
                      title: "THIS IS A TEST",
                      status: "waiting",
                      date: "22-03-2019")
                ],
              ),
            ),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/create');
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ));
  }
}
