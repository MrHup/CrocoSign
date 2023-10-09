import 'dart:async';
import 'dart:convert';
import 'dart:math';

import 'package:crocosign/static/agreement.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

FirebaseDatabase database = FirebaseDatabase.instance;

String generateRandomString(int len) {
  var r = Random();
  const _chars = 'abcdefghijklmnopqrstuvwxyz';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

Future<void> createAgreement(Agreement agreement) async {
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  final userMail = FirebaseAuth.instance.currentUser!.email;
  final userMailb64 = stringToBase64.encode(userMail!);

  List<String> emails = [];
  for (int i = 0; i < agreement.signers.length; i += 2) {
    emails.add(stringToBase64.encode(agreement.signers[i + 1]));
  }

  for (var email in emails) {
    await database.ref("users").child(email).push().set({
      "title": agreement.title,
      "topic": agreement.topic,
      "signers": agreement.signers,
      "country": agreement.country,
      "url": agreement.url,
      "idDropbox": agreement.idDropbox,
      "date": agreement.date,
      "status": agreement.status
    });
  }

  await database.ref("users").child(userMailb64).push().set({
    "title": agreement.title,
    "topic": agreement.topic,
    "signers": agreement.signers,
    "country": agreement.country,
    "url": agreement.url,
    "idDropbox": agreement.idDropbox,
    "date": agreement.date,
    "status": agreement.status
  });
}

Future<List<Agreement>> getAgreementsForUser() async {
  List<Agreement> agreements = [];
  print("Getting agreements");

  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  final userMail = FirebaseAuth.instance.currentUser!.email;
  final userMailb64 = stringToBase64.encode(userMail!);

  final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('users/$userMailb64').get();
  if (snapshot.exists) {
    for (var child in snapshot.children) {
      var agreementMap = child.value as Map<Object?, Object?>;
      var agreement = Agreement(
        title: agreementMap['title'] as String,
        topic: agreementMap['topic'] as String,
        signers: List<String>.from(agreementMap['signers'] as List<dynamic>),
        country: agreementMap['country'] as String,
        url: agreementMap['url'] as String,
        idDropbox: agreementMap['idDropbox'] as String,
        date: agreementMap['date'] as String,
        status: agreementMap['status'] as String,
      );
      agreements.add(agreement);
    }
  } else {
    print('No data available.');
  }
  return agreements;
}

void updateAgreementForUser(Agreement agreement) async {
  Codec<String, String> stringToBase64 = utf8.fuse(base64);
  final userMail = FirebaseAuth.instance.currentUser!.email;
  final userMailb64 = stringToBase64.encode(userMail!);

  final ref = FirebaseDatabase.instance.ref();
  final snapshot = await ref.child('users/$userMailb64').get();
  if (snapshot.exists) {
    for (var child in snapshot.children) {
      var agreementMap = child.value as Map<Object?, Object?>;
      if (agreementMap['idDropbox'] == agreement.idDropbox) {
        await ref
            .child('users/$userMailb64/${child.key}')
            .update({"status": agreement.status});
      }
    }
  } else {
    print('No data available.');
  }
}
