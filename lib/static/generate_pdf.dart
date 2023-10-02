import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfPreview extends StatelessWidget {
  PdfPreview({super.key});

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

  @override
  Widget build(BuildContext context) {
    final ExportDelegate exportDelegate = ExportDelegate(options: options);

    return Column(
      children: [
        // button to export
        ElevatedButton(
          onPressed: () async {
            // export pdf
            final pdfFile = await exportDelegate
                .exportToPdfDocument('someFrameId', overrideOptions: options);
            // await pdfFile.writeAsBytes(await pdf.save());
            final file = File("example.pdf");
            await file.writeAsBytes(await pdfFile.save());
          },
          child: const Text("Export"),
        ),
        ExportFrame(
          frameId: 'someFrameId',
          exportDelegate: exportDelegate,
          child: const Column(
            children: [
              Text("Some text"),
              Text("Some text, but on a second line"),
            ],
          ), // the widget you want to export
        ),
      ],
    );
  }
}
