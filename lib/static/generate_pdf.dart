import 'dart:typed_data';

import 'package:crocosign/static/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

class PdfPreviewGenerate extends StatelessWidget {
  PdfPreviewGenerate({super.key});

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

  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        pageFormat: format,
        build: (context) => pw.Placeholder(),
      ),
    );

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('Hello World'),
          ); // Center
        })); // Page

    return PdfPreview(
      maxPageWidth: 700,
      // build: (format) => _generatePdf(format, "Test"),
      build: (format) => _generateFancyPdf(),
    );
  }
}
