// ignore_for_file: unused_catch_clause

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// import 'signup.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool incorrect = false;

  void _login() async {
    showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      incorrect = false;
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      setState(() {
        incorrect = true;
      });
    }
    if (!incorrect) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
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
            if (incorrect) const SizedBox(height: 20),
            if (incorrect)
              const Text(
                'Incorrect email or password',
                style: TextStyle(color: Colors.red),
              ),
            const SizedBox(height: 20),
            TextButton(
                onPressed: () {
                  _login();
                },
                child: const Text('Login')),
            const SizedBox(height: 40),
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text('Don\'t have an account? Sign up!')),
          ],
        ),
      ),
    );
  }
}
