import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';

class Globals {
  static Color backgroundColor = const Color(0xffececec);
  static Color primaryColor = const Color(0xff1da74c);
  static Color secondaryColor = const Color(0xff003c3e);
  static Color tertiaryColor = const Color(0xff197954);

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
  static BuildContext? context;

  static User? user;
}
