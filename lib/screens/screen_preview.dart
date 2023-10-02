import 'package:crocosign/static/generate_pdf.dart';
import 'package:flutter/material.dart';

class PreviewScreen extends StatelessWidget {
  const PreviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: PdfPreviewGenerate());
  }
}
