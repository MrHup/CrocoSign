import 'package:crocosign/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final initials = user.email!
        .split('@')[0]
        .split('.')
        .map((word) => word[0].toUpperCase())
        .take(2)
        .join();

    return Scaffold(
      bottomNavigationBar: BottomNavBar((index) => goToScreen(context, index)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Text(
                initials,
                style: const TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(height: 20),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                // ignore: use_build_context_synchronously
                Navigator.pushNamedAndRemoveUntil(
                    context, '/login', (route) => false);
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
