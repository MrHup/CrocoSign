import 'package:crocosign/static/globals.dart';

import 'package:crocosign/widgets/pencil_progress_indicator.dart';
import 'package:flutter/material.dart';

import 'package:printing/printing.dart';

// ignore: must_be_immutable
class DownloadPreviewScreen extends StatelessWidget {
  DownloadPreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Globals.context = context;
    return Scaffold(
      backgroundColor: Colors.white,
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
        build: (format) => Globals.downloadPdfBytes,
      ),
    );
  }
}
