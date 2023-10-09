import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:crocosign/static/globals.dart';
import 'package:http/http.dart' as http;
import 'package:crocosign/static/config.dart';
import 'package:path_provider/path_provider.dart';

Future<void> downloadAgreement(String id) async {
  var headers = {'Authorization': 'Basic ${Env.dropboxToken}'};
  var request = http.Request(
      'GET',
      Uri.parse(
          '${Env.dropboxBaseUrl}/signature_request/files/$id?file_type=pdf'));

  request.headers.addAll(headers);
  print(headers);
  print('${Env.dropboxBaseUrl}/signature_request/files/$id?file_type=pdf');

  var response = await request.send();

  if (response.statusCode == 200) {
    // print(await response.stream.bytesToString());
    print(response.statusCode);

    var dir = await getTemporaryDirectory();
    File file = File("${dir.path}/agreement.pdf");

    Uint8List bytes = await response.stream.toBytes();
    Globals.downloadPdfBytes = bytes;

    await file.writeAsBytes(bytes);
    print(file.path);
  } else {
    print(response.reasonPhrase);
  }
}

Future<String> getNewStatus(String id) async {
  var headers = {'Authorization': 'Basic ${Env.dropboxToken}'};
  var request = http.Request(
      'GET', Uri.parse('${Env.dropboxBaseUrl}/signature_request/$id'));

  request.headers.addAll(headers);

  var response = await request.send();

  if (response.statusCode == 200) {
    final String responseStr = await response.stream.bytesToString();
    final bool hasError =
        jsonDecode(responseStr)["signature_request"]["has_error"];
    final bool isComplete =
        jsonDecode(responseStr)["signature_request"]["is_complete"];
    final bool isDeclined =
        jsonDecode(responseStr)["signature_request"]["is_declined"];

    if (hasError) {
      return "error";
    } else if (isDeclined) {
      return "declined";
    } else if (isComplete) {
      return "completed";
    } else {
      return "pending";
    }
  } else {
    print(response.statusCode);
    print(response.reasonPhrase);
    return "error";
  }
}
