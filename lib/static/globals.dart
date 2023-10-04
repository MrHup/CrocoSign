import 'package:flutter/material.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';

class Globals {
  static Color backgroundColor = const Color(0xffececec);
  static Color primaryColor = const Color(0xff1da74c);
  static Color secondaryColor = const Color(0xff003c3e);

  static ExportOptions options = ExportOptions(
    pageFormatOptions: const PageFormatOptions.a4(),
    textFieldOptions: TextFieldOptions.uniform(
      interactive: false,
    ),
    checkboxOptions: CheckboxOptions.uniform(
      interactive: false,
    ),
  );

  static ExportDelegate exportDelegate = ExportDelegate(options: options);
}
