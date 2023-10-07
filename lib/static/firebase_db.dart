import 'dart:math';

import 'package:crocosign/static/agreement.dart';
import 'package:crocosign/static/globals.dart';
import 'package:firebase_database/firebase_database.dart';

// class FirebaseDb {
//   static final FirebaseDb _instance = FirebaseDb._internal();
//   final FirebaseDatabase _database = FirebaseDatabase.instance;

//   factory FirebaseDb() {
//     return _instance;
//   }

//   FirebaseDb._internal();

//   Future<void> createAgreement(Agreement agreement) async {
//     await _database.reference().child("agreements").push().set({
//       "title": agreement.title,
//       "topic": agreement.topic,
//       "signers": agreement.signers,
//       "country": agreement.country,
//       "contract": agreement.contract,
//       "pdf": agreement.pdf,
//       "created_at": DateTime.now().millisecondsSinceEpoch,
//     });
//   }

//   Future<List<Agreement>> fetchAgreements() async {
//     List<Agreement> agreements = [];
//     await _database
//         .reference()
//         .child("agreements")
//         .orderByChild("created_at")
//         .once()
//         .then((DataSnapshot snapshot) {
//       Object? values = snapshot.value;
//       values?.forEach((key, values) {
//         agreements.add(Agreement.fromJson(values));
//       });
//     });
//     return agreements;
//   }
// }

FirebaseDatabase database = FirebaseDatabase.instance;

String generateRandomString(int len) {
  var r = Random();
  const _chars = 'abcdefghijklmnopqrstuvwxyz';
  return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
}

Future<void> createAgreement(Agreement agreement) async {
  await database.ref("users").child(Globals.user!.uid).push().set({
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
