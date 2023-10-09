import 'package:crocosign/static/globals.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key});

  Future<int> getUserApiReqLeft() async {
    // TODO: Implement API request to get remaining API signature requests left for the user
    return 10;
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final initials = user.email!
        .split('@')[0]
        .split('.')
        .map((word) => word[0].toUpperCase())
        .take(2)
        .join();

    return Stack(
      children: [
        SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 200,
            child: Container(color: Globals.backgroundColor)),
        Center(
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
              FutureBuilder<int>(
                future: getUserApiReqLeft(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      'Remaining API signatures: ${snapshot.data}',
                      style: TextStyle(fontSize: 16),
                    );
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Globals.secondaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  // ignore: use_build_context_synchronously
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (route) => false);
                },
                icon: Icon(Icons.logout),
                label: const Text('Logout'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
