import 'package:crocosign/screens/screen_agreements.dart';
import 'package:crocosign/screens/screen_create.dart';
import 'package:crocosign/screens/screen_loading.dart';
import 'package:crocosign/screens/screen_login.dart';
import 'package:crocosign/screens/screen_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() async {
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
        '/agreements': (BuildContext context) => AgreementScreen(),
        '/create': (BuildContext context) => CreateScreen(),
        '/loading': (BuildContext context) => const LoadingScreen(),
        '/preview': (BuildContext context) => const PreviewScreen(),
      },
      home: LoginScreen(),
    );
  }
}
