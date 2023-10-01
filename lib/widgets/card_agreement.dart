import 'package:crocosign/static/globals.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardAgreement extends StatelessWidget {
  CardAgreement(
      {required this.title,
      required this.status,
      required this.date,
      super.key});
  String title;
  String status;
  String date;

  @override
  Widget build(BuildContext context) {
    if (title.length > 20) {
      title = "${title.substring(1, 20)} [...]";
    }

    Color color = Colors.green;
    if (status == "waiting") {
      color = Colors.orange;
    } else if (status == "signed") {
      color = Globals.primaryColor;
    } else if (status == "declined") {
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
                    Container(
                      color: color,
                      child: const SizedBox(
                        width: 8,
                        height: 50,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      children: [
                        Text(title),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Row(
                              children: [
                                const Text("Status: "),
                                Text(status, style: TextStyle(color: color)),
                              ],
                            ),
                            // Container(color: Colors.green, child: Text(date)),
                          ],
                        )
                      ],
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
