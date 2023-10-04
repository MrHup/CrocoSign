import 'package:crocosign/static/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';

// ignore: must_be_immutable
class EditableScreen extends StatefulWidget {
  EditableScreen(this.title, this.content, this.signer, this.date, {super.key});

  String title, content, signer, date;

  @override
  State<EditableScreen> createState() => _EditableScreenState();
}

class _EditableScreenState extends State<EditableScreen> {
  bool isEditable = false;

  final Widget fixedLogo = Image.asset(
    'assets/logo_text.png',
    height: 50,
  );

  Widget buildEditable(bool isEditable) {
    const double fixedHeight = 500;
    const TextStyle style = TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
    );

    const TextStyle styleSmall = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.bold,
    );

    Widget listView = ListView(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isEditable
                  ? SizedBox(
                      width: 200,
                      child: TextField(
                        controller: TextEditingController(text: widget.title),
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: style,
                      ),
                    )
                  : Text(widget.title, style: style),
              fixedLogo
            ],
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: isEditable
              ? SizedBox(
                  width: 200,
                  child: TextField(
                    controller: TextEditingController(text: widget.content),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                    ),
                    style: styleSmall,
                  ),
                )
              : Text(widget.content, style: styleSmall),
        ),
      ],
    );

    if (isEditable == true) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(height: fixedHeight, child: listView),
      );
    }
    return ExportFrame(
      frameId: 'someFrameId',
      exportDelegate: Globals.exportDelegate,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(height: fixedHeight, child: listView),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Globals.exportDelegate = ExportDelegate(options: Globals.options);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          buildEditable(isEditable),
          Row(
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey[300],
                  child: TextButton.icon(
                    onPressed: () async {
                      setState(() {
                        isEditable = !isEditable;
                      });
                    },
                    icon: const Icon(Icons.edit),
                    label: const Text('Edit'),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  color: Globals.primaryColor,
                  child: TextButton.icon(
                    onPressed: () async {
                      Navigator.pushNamed(context, '/preview');
                    },
                    icon: const Icon(Icons.picture_as_pdf, color: Colors.white),
                    label: const Text('Preview',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
