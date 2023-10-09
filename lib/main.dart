import 'package:crocosign/screens/screen_download_preview.dart';
import 'package:crocosign/screens/screen_editable.dart';
import 'package:crocosign/screens/screen_home.dart';
import 'package:crocosign/screens/screen_loading.dart';
import 'package:crocosign/screens/screen_login.dart';
import 'package:crocosign/screens/screen_pdf_preview.dart';
import 'package:crocosign/screens/screen_register.dart';
import 'package:crocosign/static/agreement.dart';
import 'package:crocosign/static/globals.dart';
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
        primarySwatch: MaterialColor(
          Globals.primaryColor.value,
          <int, Color>{
            50: Globals.primaryColor.withOpacity(0.1),
            100: Globals.primaryColor.withOpacity(0.2),
            200: Globals.primaryColor.withOpacity(0.3),
            300: Globals.primaryColor.withOpacity(0.4),
            400: Globals.primaryColor.withOpacity(0.5),
            500: Globals.primaryColor.withOpacity(0.6),
            600: Globals.primaryColor.withOpacity(0.7),
            700: Globals.primaryColor.withOpacity(0.8),
            800: Globals.primaryColor.withOpacity(0.9),
            900: Globals.primaryColor.withOpacity(1),
          },
        ),
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
        '/download': (BuildContext context) => DownloadPreviewScreen(),
      },
      home: LoginScreen(),
    );
  }
}
