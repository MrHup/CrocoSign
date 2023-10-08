import 'package:crocosign/screens/screen_agreements.dart';
import 'package:crocosign/screens/screen_create.dart';
import 'package:crocosign/screens/screen_profile.dart';
import 'package:crocosign/static/globals.dart';
import 'package:crocosign/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1;

  void setIndex(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget appropriateWidget(int index) {
    switch (index) {
      case 0:
        return const CreateScreen();
      case 1:
        return AgreementScreen();
      case 2:
        return const ProfileScreen();
      case 3:
        return Container();
      default:
        return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        bottomNavigationBar: BottomNavBar((index) => setIndex(index)),
        floatingActionButton: _selectedIndex == 1
            ? FloatingActionButton(
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
                backgroundColor: Globals.primaryColor,
                child: const Icon(Icons.add),
              )
            : null,
        body: appropriateWidget(_selectedIndex));
  }
}
