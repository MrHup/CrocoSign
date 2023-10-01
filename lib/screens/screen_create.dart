import 'package:crocosign/static/globals.dart';
import 'package:crocosign/widgets/stepper_creation.dart';
import 'package:flutter/material.dart';

class CreateScreen extends StatelessWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Globals.backgroundColor,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: const Text("Create Agreement",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ),
          const Card(
              child: Column(
            children: [
              // input text fields
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a search term'),
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a search term'),
              ),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter a search term'),
              ),
            ],
          )),
          StepperRegistration()
        ],
      ),
    );
  }
}
