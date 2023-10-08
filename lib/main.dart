import 'package:crocosign/screens/screen_editable.dart';
import 'package:crocosign/screens/screen_home.dart';
import 'package:crocosign/screens/screen_loading.dart';
import 'package:crocosign/screens/screen_login.dart';
import 'package:crocosign/screens/screen_pdf_preview.dart';
import 'package:crocosign/screens/screen_register.dart';
import 'package:crocosign/static/agreement.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainRouter());
}

class MainRouter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CrocoSign',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: <String, WidgetBuilder>{
        '/login': (BuildContext context) => LoginScreen(),
        '/register': (BuildContext context) => RegisterScreen(),
        '/loading': (BuildContext context) => const LoadingScreen(),
        '/preview': (BuildContext context) => PdfPreviewScreen(),
        '/editable': (BuildContext context) => EditableScreen(Agreement(
            title: "Test",
            country: "Test",
            date: "",
            signers: ["Flavius"],
            idDropbox: "",
            status: "waiting",
            topic: "",
            url: "")),
        '/home': (BuildContext context) => const HomeScreen(),
      },
      home: LoginScreen(),
    );
  }
}
