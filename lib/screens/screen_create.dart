import 'package:crocosign/static/agreement.dart';
import 'package:crocosign/static/generate_document.dart';
import 'package:crocosign/static/globals.dart';
import 'package:crocosign/static/input_agreement.dart';
import 'package:crocosign/widgets/country_picker.dart';
import 'package:crocosign/widgets/logo_banner.dart';
import 'package:crocosign/widgets/long_input_field.dart';
import 'package:crocosign/widgets/short_input_field.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Globals.context = context;
    TextEditingController titleController = TextEditingController();
    TextEditingController descriptionController = TextEditingController();
    TextEditingController signersController = TextEditingController();
    TextEditingController countryController = TextEditingController();
    return Column(
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
                        String contract =
                            await generatePdfContent(inputAgreement);
                        String formattedDate =
                            DateFormat('MM/dd/yyyy').format(DateTime.now());

                        Agreement agreement = Agreement(
                          title: inputAgreement.title,
                          topic: contract,
                          signers: inputAgreement.signers,
                          country: inputAgreement.country,
                          idDropbox: "pending",
                          status: "pending",
                          url: "pending",
                          date: formattedDate,
                        );

                        Globals.agreement = agreement;
                        // await createAgreement(agreement);

                        Globals.widgets = documentFormatter(contract);
                        Navigator.pushNamed(Globals.context!, '/editable');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Globals.secondaryColor,
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
    );
  }
}
