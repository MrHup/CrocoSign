import 'package:crocosign/static/globals.dart';
import 'package:flutter/material.dart';

class LongInputField extends StatelessWidget {
  const LongInputField(this.controller, {this.hint = "", super.key});

  final TextEditingController controller;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return TextField(
      minLines: 5,
      maxLength: 1000,
      controller: controller,
      maxLines: null,
      keyboardType: TextInputType.multiline,
      decoration: InputDecoration(
        filled: true,
        fillColor: Globals.backgroundColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15.0),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.all(16.0),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
