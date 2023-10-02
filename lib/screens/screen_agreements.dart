import 'package:crocosign/static/globals.dart';
import 'package:crocosign/widgets/card_agreement.dart';
import 'package:crocosign/widgets/logo_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';

// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

class AgreementScreen extends StatelessWidget {
  AgreementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // create instance of ExportDelegate
    final ExportOptions options = ExportOptions(
      pageFormatOptions: const PageFormatOptions.a4(),
      textFieldOptions: TextFieldOptions.uniform(
        interactive: false,
      ),
      checkboxOptions: CheckboxOptions.uniform(
        interactive: false,
      ),
    );

    Globals.exportDelegate = ExportDelegate(options: options);

    return Scaffold(
        backgroundColor: Colors.white,
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
                      date: "22-03-2019"),
                  ExportFrame(
                    frameId: 'someFrameId',
                    exportDelegate: Globals.exportDelegate,
                    child: const Column(
                      children: [
                        Text("Some text"),
                        Text("Some text, but on a second line"),
                      ],
                    ), // the widget you want to export
                  ),
                ],
              ),
            ),
          ),
        ]),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, '/preview'); // /create
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ));
  }
}
