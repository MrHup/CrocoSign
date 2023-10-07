import 'package:crocosign/static/globals.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void checkUserLogin() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        Globals.user = FirebaseAuth.instance.currentUser;
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    });
  }

  void attemptLogin(String emailAddress, String password) async {
    try {
      final credentials = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
      Globals.user = credentials.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  void initState() {
    checkUserLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Expanded(flex: 1, child: Container()),
          Expanded(
            flex: 8,
            child: ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Image(
                    image: AssetImage('assets/logo_text.png'),
                    height: 200,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Column(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(bottom: 4.0),
                            child: Text("Email"),
                          ),
                          TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              prefixIcon: const Icon(Icons.person),
                              filled: true,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: 4.0),
                              child: Text(
                                "Password",
                              ),
                            ),
                            TextField(
                              controller: _passwordController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                prefixIcon: const Icon(Icons.lock),
                                filled: true,
                              ),
                              obscureText: true,
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: ElevatedButton(
                          style: ButtonStyle(
                            minimumSize: MaterialStateProperty.all<Size>(
                                const Size(double.infinity, 55)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                          onPressed: () {
                            attemptLogin(_emailController.text,
                                _passwordController.text);
                          },
                          child: const Text("Sign In"),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/register', (route) => false);
                          },
                          child: Row(
                            children: [
                              const Text("New here?",
                                  style: TextStyle(color: Colors.grey)),
                              Text(" Sign Up now!",
                                  style:
                                      TextStyle(color: Globals.primaryColor)),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(flex: 1, child: Container()),
        ],
      ),
    );
  }
}
