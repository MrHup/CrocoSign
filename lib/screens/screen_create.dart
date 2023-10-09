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

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  bool popupEnabled = false;
  List<String> globalSigners = [];
  List<Widget> smallAvatars = [];

  void enablePopup() {
    setState(() {
      popupEnabled = !popupEnabled;
    });
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Globals.context = context;

    return Stack(
      children: [
        Column(
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
                        const SizedBox(height: 15),
                        CountryPickerWidget(countryController),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: enablePopup,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12.0, horizontal: 16.0),
                            decoration: BoxDecoration(
                              color: Globals.backgroundColor,
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: globalSigners.isNotEmpty
                                      ? Row(
                                          children: smallAvatars,
                                        )
                                      : Text(
                                          'Select signers',
                                          style: TextStyle(
                                            color: globalSigners.isNotEmpty
                                                ? Colors.black
                                                : Colors.grey,
                                            fontSize: 16.0,
                                          ),
                                        ),
                                ),
                                const SizedBox(width: 8.0),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (titleController.text.isEmpty ||
                                descriptionController.text.isEmpty ||
                                countryController.text.isEmpty ||
                                globalSigners.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'Please fill all the required fields'),
                                ),
                              );
                              return;
                            }
                            List<String> signers = globalSigners;
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
        ),
        popupEnabled
            ? GestureDetector(
                onTap: enablePopup,
                child: Container(
                  color: Colors.black38,
                  child: Center(
                      child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ShortInputField(nameController, hint: "Name"),
                            const SizedBox(height: 10),
                            ShortInputField(emailController, hint: "Email"),
                            const SizedBox(height: 10),
                            // submit button
                            ElevatedButton(
                              onPressed: () async {
                                if (emailController.text.isNotEmpty &&
                                    nameController.text.isNotEmpty) {
                                  globalSigners.add(nameController.text);
                                  globalSigners.add(emailController.text);
                                  final initials = emailController.text
                                      .split('@')[0]
                                      .split('.')
                                      .map((word) => word[0].toUpperCase())
                                      .take(2)
                                      .join();
                                  smallAvatars.add(
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: CircleAvatar(
                                          radius: 20,
                                          backgroundColor: Colors.grey,
                                          child: Text(
                                            initials,
                                            style: const TextStyle(
                                                color: Colors.white),
                                          )),
                                    ),
                                  );
                                  emailController.clear();
                                  nameController.clear();
                                  enablePopup();
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Globals.secondaryColor,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                textStyle: const TextStyle(fontSize: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: const Text("Submit"),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
                ),
              )
            : Container()
      ],
    );
  }
}
