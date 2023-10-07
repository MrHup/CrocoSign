import 'package:crocosign/screens/screen_agreements.dart';
import 'package:crocosign/screens/screen_create.dart';
import 'package:crocosign/screens/screen_editable.dart';
import 'package:crocosign/screens/screen_loading.dart';
import 'package:crocosign/screens/screen_login.dart';
import 'package:crocosign/screens/screen_pdf_preview.dart';
import 'package:crocosign/screens/screen_profile.dart';
import 'package:crocosign/screens/screen_register.dart';
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
        '/agreements': (BuildContext context) => AgreementScreen(),
        '/create': (BuildContext context) => const CreateScreen(),
        '/loading': (BuildContext context) => const LoadingScreen(),
        '/preview': (BuildContext context) => PdfPreviewScreen(),
        '/editable': (BuildContext context) =>
            EditableScreen("TEST", "TEST", "TEST", "TEST"),
        '/profile': (BuildContext context) => const ProfileScreen(),
      },
      home: LoginScreen(),
    );
  }
}
