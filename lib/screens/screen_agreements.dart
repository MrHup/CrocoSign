import 'package:crocosign/static/agreement.dart';
import 'package:crocosign/static/firebase_db.dart';
import 'package:crocosign/widgets/card_agreement.dart';
import 'package:crocosign/widgets/logo_banner.dart';
import 'package:flutter/material.dart';

// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;

class AgreementScreen extends StatefulWidget {
  AgreementScreen({super.key});

  @override
  State<AgreementScreen> createState() => _AgreementScreenState();
}

class _AgreementScreenState extends State<AgreementScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      LogoBanner("My Agreements"),
      Container(
        child: Expanded(
          child: FutureBuilder<List<Agreement>>(
            future: getAgreementsForUser(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return RefreshIndicator(
                  onRefresh: () async {
                    // Add your refresh logic here
                    setState(() {
                      // wait 10 seconds
                      Future.delayed(const Duration(seconds: 10), () {});
                      print("It works");
                    });
                  },
                  child: ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return CardAgreement(agreement: snapshot.data![index]);
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return CircularProgressIndicator();
            },
          ),
        ),
      ),
    ]);
  }
}
