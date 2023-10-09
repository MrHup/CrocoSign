import 'package:crocosign/static/agreement.dart';
import 'package:crocosign/static/firebase_db.dart';
import 'package:crocosign/static/generate_document.dart';
import 'package:crocosign/static/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_to_pdf/flutter_to_pdf.dart';

// ignore: must_be_immutable
class EditableScreen extends StatefulWidget {
  EditableScreen(this.agreement, {super.key});

  Agreement agreement;

  @override
  State<EditableScreen> createState() => _EditableScreenState();
}

class _EditableScreenState extends State<EditableScreen> {
  @override
  void initState() {
    makeEditableList();
    super.initState();
  }

  bool isEditable = false;

  // -- const decorations
  final Widget fixedLogo = Image.asset(
    'assets/logo_text.png',
    height: 50,
  );

  TextStyle style = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  TextStyle styleSmall = const TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  List<Widget> editableList = [];
  List<TextEditingController> controllers = [];
  final titleController = TextEditingController(text: Globals.agreement!.title);

  // --------------------

  List<Widget> makeEditableList() {
    print("Making editable list. Length of widgets: ${Globals.widgets.length}");
    editableList = [];
    controllers = [];

    for (var textwidget in Globals.widgets) {
      if (textwidget is Text) {
        controllers.add(TextEditingController(text: textwidget.data));
        editableList.add(Container(
          color: Globals.backgroundColor,
          child: TextField(
            minLines: 1,
            maxLines: 8,
            controller: controllers.last,
            // decoration: const InputDecoration(
            //   border: OutlineInputBorder(),
            // ),
            style: textwidget.style,
          ),
        ));
      } else {
        editableList.add(textwidget);
        controllers.add(TextEditingController());
      }
    }

    return editableList;
  }

  Widget buildEditable(bool isEditable) {
    double fixedHeight = MediaQuery.of(context).size.height - 100;

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
                        controller: titleController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        style: style,
                      ),
                    )
                  : Text(Globals.agreement!.title, style: style),
              fixedLogo
            ],
          ),
        ),
        const SizedBox(height: 20),
        Align(
          alignment: Alignment.centerLeft,
          child: Column(children: isEditable ? editableList : Globals.widgets),
        ),
      ],
    );

    if (isEditable == true) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(height: fixedHeight, child: listView),
      );
    }

    Globals.originalId = generateRandomString(10);
    return ExportFrame(
      frameId: Globals.originalId,
      exportDelegate: Globals.exportDelegate,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(height: fixedHeight, child: listView),
      ),
    );
  }

  void updateText() {
    String textBlock = "";
    for (int i = 0; i < editableList.length; i++) {
      if (editableList[i] is SizedBox) {
        textBlock += "\n";
      } else {
        textBlock += controllers[i].text;
        if (i != editableList.length - 1) {
          textBlock += "\n";
        }
      }
    }

    widget.agreement.topic = textBlock;
    setState(() {
      Globals.widgets = documentFormatter(textBlock);
      makeEditableList();
      isEditable = !isEditable;
    });
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
          isEditable
              ? Row(
                  children: [
                    Expanded(
                      child: Container(
                        color: Colors.red[300],
                        child: TextButton.icon(
                          onPressed: () async {
                            setState(() {
                              isEditable = !isEditable;
                            });
                          },
                          icon: const Icon(Icons.close, color: Colors.white),
                          label: const Text('Cancel',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        color: Globals.primaryColor,
                        child: TextButton.icon(
                          onPressed: () async {
                            // iterate through controllers and update text
                            updateText();
                          },
                          icon: const Icon(Icons.save, color: Colors.white),
                          label: const Text('Save',
                              style: TextStyle(color: Colors.white)),
                        ),
                      ),
                    ),
                  ],
                )
              : Row(
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
                          icon: const Icon(Icons.picture_as_pdf,
                              color: Colors.white),
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
