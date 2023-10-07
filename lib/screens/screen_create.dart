import 'package:crocosign/static/generate_document.dart';
import 'package:crocosign/static/globals.dart';
import 'package:crocosign/static/input_agreement.dart';
import 'package:crocosign/widgets/bottom_nav_bar.dart';
import 'package:crocosign/widgets/logo_banner.dart';
import 'package:crocosign/widgets/long_input_field.dart';
import 'package:crocosign/widgets/short_input_field.dart';
import 'package:flutter/material.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController signersController = TextEditingController();
    TextEditingController countryController = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavBar((index) => print("")),
      body: Column(
        children: [
          LogoBanner("Create Agreement"),
          Expanded(
            child: Row(
              children: [
                Expanded(flex: 1, child: Container()),
                Expanded(
                  flex: 8,
                  child: ListView(
                    children: [
                      ShortInputField(titleController),
                      const SizedBox(height: 20),
                      LongInputField(descriptionController,
                          title: "Short Description"),
                      const SizedBox(height: 20),
                      ShortInputField(signersController, title: "Signers"),
                      ShortInputField(countryController, title: "Country"),
                      // generate button
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          List<String> signers = signersController.text
                              .split(",")
                              .map((e) => e.trim())
                              .toList();
                          InputAgreement inputAgreement = InputAgreement(
                              title: titleController.text,
                              topic: descriptionController.text,
                              signers: signers,
                              country: countryController.text);
                          await generatePdfContent(inputAgreement);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Globals.primaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          textStyle: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                        child: const Text("Generate"),
                      ),
                    ],
                  ),
                ),
                Expanded(flex: 1, child: Container()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
