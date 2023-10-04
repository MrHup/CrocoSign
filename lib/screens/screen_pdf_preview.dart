import 'dart:typed_data';

import 'package:crocosign/static/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfPreviewScreen extends StatelessWidget {
  PdfPreviewScreen({super.key});

  final doc = pw.Document();

  Future<Uint8List> _generateFancyPdf() async {
    final ExportOptions overrideOptions = ExportOptions(
      pageFormatOptions: const PageFormatOptions.a4(),
      textFieldOptions: TextFieldOptions.uniform(
        interactive: false,
      ),
      checkboxOptions: CheckboxOptions.uniform(
        interactive: false,
      ),
    );

    final pdf = await Globals.exportDelegate
        .exportToPdfDocument('someFrameId', overrideOptions: overrideOptions);

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: PdfPreview(
        canChangeOrientation: false,
        canChangePageFormat: false,
        maxPageWidth: 700,
        build: (format) => _generateFancyPdf(),
      ),
    );
  }
}
