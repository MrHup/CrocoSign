import 'package:crocosign/static/globals.dart';
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
    return Scaffold(
      backgroundColor: Colors.white,
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
                      // generate button
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {},
                        child: const Text("Generate"),
                        style: ElevatedButton.styleFrom(
                          primary: Globals.primaryColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 20),
                          textStyle: const TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
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
