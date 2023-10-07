import 'package:crocosign/static/generate_document.dart';
import 'package:crocosign/static/globals.dart';
import 'package:crocosign/static/input_agreement.dart';
import 'package:crocosign/widgets/bottom_nav_bar.dart';
import 'package:crocosign/widgets/country_picker.dart';
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
      bottomNavigationBar: BottomNavBar((index) => goToScreen(context, index)),
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
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    children: [
                      ShortInputField(titleController, hint: "Title"),
                      const SizedBox(height: 20),
                      LongInputField(descriptionController,
                          hint: "Short Description"),
                      CountryPickerWidget(countryController),
                      const SizedBox(height: 20),
                      ShortInputField(signersController, hint: "Signers"),
                      const SizedBox(height: 20),
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

                          Navigator.pushNamedAndRemoveUntil(
                              context, '/loading', (route) => false);
                          await generatePdfContent(inputAgreement);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Globals.primaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 14),
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
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
