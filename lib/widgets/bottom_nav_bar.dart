import 'package:crocosign/static/globals.dart';
import 'package:flutter/material.dart';
import 'package:flutter_snake_navigationbar/flutter_snake_navigationbar.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar(this.onTap, {super.key});
  final void Function(int index) onTap;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedItemPosition = 0;
  @override
  Widget build(BuildContext context) {
    return SnakeNavigationBar.color(
      behaviour: SnakeBarBehaviour.floating,
      snakeShape: SnakeShape.circle,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      padding: const EdgeInsets.all(8),

      ///configuration for SnakeNavigationBar.color
      snakeViewColor: Globals.tertiaryColor,
      backgroundColor: Globals.primaryColor,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.white,

      // showUnselectedLabels: true,
      showSelectedLabels: true,

      currentIndex: _selectedItemPosition,
      onTap: (index) {
        setState(() => _selectedItemPosition = index);
        widget.onTap(index);
      },
      items: const [
        BottomNavigationBarItem(
            icon: Icon(Icons.edit_document), label: 'New Doc'),
        BottomNavigationBarItem(icon: Icon(Icons.picture_as_pdf), label: 'PDF'),
        BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Profile'),
        // BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search')
      ],
    );
  }
}

void goToScreen(BuildContext context, int index) {
  print("Calling this function");
  if (index == 0) {
    Navigator.pushNamedAndRemoveUntil(context, '/create', (route) => false);
  } else if (index == 1) {
    Navigator.pushNamedAndRemoveUntil(context, '/agreements', (route) => false);
  } else if (index == 2) {
    Navigator.pushNamedAndRemoveUntil(context, '/profile', (route) => false);
  }
}
