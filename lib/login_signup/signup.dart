import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'login.dart';

class MySignupPage extends StatefulWidget {
  const MySignupPage({super.key});

  @override
  State<MySignupPage> createState() => _MySignupPageState();
}

class _MySignupPageState extends State<MySignupPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confPasswordController = TextEditingController();
  bool incorrect = false;

  void _signup() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      if (passwordController.text == confPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
        incorrect = false;

        await Future.delayed(const Duration(seconds: 1));

        // Navigate to the home page upon successful sign-up
        Navigator.popAndPushNamed(context, '/auth');
      } else {
        throw FirebaseAuthException(code: "e");
      }
      // ignore: unused_catch_clause
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      setState(() {
        incorrect = true;
      });
    }
    // if (!incorrect) {
    //   // ignore: use_build_context_synchronously
    //   Navigator.pop(context);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'enter email'),
              controller: emailController,
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'enter password'),
              controller: passwordController,
            ),
            const SizedBox(height: 20),
            TextField(
              obscureText: true,
              decoration: const InputDecoration(labelText: 'confirm password'),
              controller: confPasswordController,
            ),
            if (incorrect) const SizedBox(height: 20),
            if (incorrect)
              const Text(
                'email invalid or passwords don\'t match',
                style: TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  _signup();
                },
                child: const Text('Sign Up')),
            const SizedBox(height: 40),
            const SizedBox(height: 40),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/login');
                },
                child: const Text('Already have an account? Login!')),
          ],
        ),
      ),
    );
  }
}
