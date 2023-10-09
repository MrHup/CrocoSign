import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

import 'package:crocosign/static/agreement.dart';
import 'package:crocosign/static/config.dart';
import 'package:crocosign/static/firebase_db.dart';
import 'package:firebase_storage/firebase_storage.dart';

final dio = Dio();

Future<String> uploadPdfToFirebaseStorage(Uint8List data) async {
  final storageRef = FirebaseStorage.instance.ref();
  final randomString = generateRandomString(10);
  final pdfRef = storageRef.child("$randomString.pdf");
  try {
    await pdfRef.putData(data);
  } on FirebaseException catch (e) {
    // ignore: avoid_print
    print(e);
    return "Error";
  }

  return await pdfRef.getDownloadURL();
}

Future<Agreement> requestDropboxSignatures(Agreement agreement) async {
  List<Object> dropSigners = [];
  for (int i = 0; i < agreement.signers.length; i++) {
    dropSigners.add({
      "email_address": "flavius.holerga+1@gmail.com",
      "name": agreement.signers[i],
      "order": i
    });
  }

  var headers = {
    'Content-Type': 'application/json',
    'Authorization': 'Basic ${Env.dropboxToken}',
  };
  var request = http.Request(
      'POST', Uri.parse('${Env.dropboxBaseUrl}/signature_request/send'));
  request.body = json.encode({
    "test_mode": true,
    "title": agreement.title,
    "subject": "CrocoSign - ${agreement.title}",
    "message":
        "Your signature is requested on this document about ${agreement.title}.",
    "signers": dropSigners,
    "cc_email_addresses": [],
    "file_urls": [agreement.url],
    "signing_options": {
      "draw": true,
      "type": true,
      "upload": true,
      "phone": false,
      "default_type": "draw"
    },
  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();

  try {
    print(response.statusCode);
    final String responseStr = await response.stream.bytesToString();
    final String itemId =
        jsonDecode(responseStr)["signature_request"]["signature_request_id"];
    final bool hasError =
        jsonDecode(responseStr)["signature_request"]["has_error"];
    final bool isComplete =
        jsonDecode(responseStr)["signature_request"]["is_complete"];
    final bool isDeclined =
        jsonDecode(responseStr)["signature_request"]["is_declined"];

    if (hasError || isDeclined) {
      agreement.status = "error";
    } else if (isComplete) {
      agreement.status = "completed";
    } else {
      agreement.status = "pending";
    }

    agreement.idDropbox = itemId;

    return agreement;
  } catch (e) {
    print(e);
  }
  return agreement;
}

void storeAgreementInFirebaseDb() async {}
