import 'dart:typed_data';

import 'package:crocosign/static/generate_document.dart';
import 'package:crocosign/static/globals.dart';
import 'package:crocosign/widgets/pencil_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PdfPreviewScreen extends StatelessWidget {
  PdfPreviewScreen({super.key});

  Future<Uint8List> _generateFancyPdf() async {
    final ExportOptions overrideOptions = Globals.options;
    final pdf = await Globals.exportDelegate
        .exportToPdfDocument('someFrameId', overrideOptions: overrideOptions);

    return pdf.save();
  }

  Future<Uint8List> generatePDFDoc() async {
    List<pw.Widget> widgets = [];

    // add title and logo
    widgets.add(
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.spaceBetween, children: [
      pw.Text(Globals.agreement!.title,
          style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 20)),
      pw.Image(
        await imageFromAssetBundle("assets/logo_text.png"),
        width: 100,
        height: 100,
      ),
    ]));

    widgets.add(pw.SizedBox(height: 20));

    for (var widget in Globals.widgets) {
      if (widget is Text && isTextUpper(widget.data!)) {
        widgets.add(pw.Text(widget.data!,
            style: pw.TextStyle(fontWeight: pw.FontWeight.bold, fontSize: 14)));
      } else if (widget is Text) {
        widgets.add(
            pw.Text(widget.data!, style: const pw.TextStyle(fontSize: 14)));
      } else {
        widgets.add(pw.SizedBox(height: 10));
      }
    }

    final pdf = pw.Document();
    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => widgets, //here goes the widgets list
      ),
    );

    return pdf.save();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // drawerScrimColor: Colors.black,
      body: PdfPreview(
        pdfPreviewPageDecoration: const BoxDecoration(
          color: Colors.white,
        ),
        scrollViewDecoration: BoxDecoration(
          color: Globals.backgroundColor,
        ),
        previewPageMargin:
            const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        allowPrinting: true,
        canDebug: false,
        canChangeOrientation: false,
        canChangePageFormat: false,
        maxPageWidth: 700,
        loadingWidget: const Center(child: PencilProgressIndicator()),
        build: (format) => generatePDFDoc(),
      ),
    );
  }
}
