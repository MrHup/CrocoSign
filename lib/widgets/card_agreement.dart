import 'package:crocosign/static/agreement.dart';
import 'package:crocosign/static/download_agreement.dart';
import 'package:crocosign/static/globals.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardAgreement extends StatelessWidget {
  CardAgreement({required this.agreement, super.key});
  Agreement agreement;

  @override
  Widget build(BuildContext context) {
    if (agreement.title.length > 20) {
      agreement.title = "${agreement.title.substring(1, 20)} [...]";
    }

    Color color = Colors.green;
    if (agreement.status == "pending") {
      color = Colors.orange;
    } else if (agreement.status == "signed") {
      color = Globals.primaryColor;
    } else if (agreement.status == "declined") {
      color = Colors.red;
    }

    return Row(
      children: [
        Expanded(flex: 1, child: Container()),
        Expanded(
          flex: 16,
          child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15.0),
                      child: Container(
                        color: color,
                        width: 8,
                        height: 50,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(agreement.title),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () async {
                                      print("Hi");
                                      await downloadAgreement(
                                          agreement.idDropbox);
                                      Navigator.pushNamed(context, '/download');
                                    },
                                    child: Icon(
                                      Icons.remove_red_eye,
                                      color: Globals.secondaryColor,
                                    ),
                                  ),
                                  // SizedBox(width: 5),
                                  // Icon(Icons.more_vert),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Text("Status: "),
                                  Text(agreement.status,
                                      style: TextStyle(color: color)),
                                ],
                              ),
                              Text(agreement.date),
                            ],
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )),
        ),
        Expanded(flex: 1, child: Container()),
      ],
    );
  }
}
