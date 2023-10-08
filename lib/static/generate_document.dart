import 'dart:convert';
import 'package:crocosign/static/input_agreement.dart';
import 'package:crocosign/static/config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<String> generatePdfContent(InputAgreement agreement) async {
  final response = await http.post(
    Uri.parse("https://api.openai.com/v1/chat/completions"),
    headers: <String, String>{
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Env.openAiKey}',
    },
    body: jsonEncode(<String, dynamic>{
      "messages": [
        {
          "role": "system",
          "content": "This is a system that produces written agreements."
        },
        {"role": "assistant", "content": "Hello"},
        {"role": "user", "content": agreement.generatePrompt()}
      ],
      "model": "gpt-3.5-turbo", // "gpt-3.5-turbo-0301",
      // "model": "text-davinci-003",
      "max_tokens": 3000,
      "temperature": 1.2,
      //   "top_p": 1,
      //   "n": 1,
      "presence_penalty": 0.65,
      "frequency_penalty": 0.35,
      //   "stop": ["\n"]
    }),
  );

  final choices = jsonDecode(response.body)["choices"];
  if (choices.length > 0) {
    String resultJson = choices[0]["message"]["content"];
    return resultJson;
  }
  return "Some error occurred.";
}

bool isTextUpper(String text) {
  return text == text.toUpperCase();
}

List<Widget> documentFormatter(String text) {
  // split into separate Text widgets based on following rules
  // 1. if line starts with a number, it is a heading
  // 2. if line starts with a bullet, it is a bullet
  // 3. if line starts with a capital letter, it is a paragraph
  // 4. all full capital text is bolded
  // 5. text between two asterisks is bolded

  List<Widget> widgets = [];
  List<String> lines = text.split("\n");

  for (String line in lines) {
    if (line.isEmpty) {
      widgets.add(const SizedBox(height: 10));
      continue;
    }
    if (line[0] == "*") {
      widgets.add(Text(
        line.substring(1, line.length - 1),
        maxLines: 8,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ));
      continue;
    }
    if (isTextUpper(line)) {
      widgets.add(Text(
        line,
        maxLines: 8,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ));
      continue;
    }
    widgets.add(Text(
      line,
      maxLines: 8,
      style: const TextStyle(fontSize: 14),
    ));
  }
  return widgets;
}
