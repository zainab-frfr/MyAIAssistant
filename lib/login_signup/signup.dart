import 'package:flutter/material.dart';
// import 'login.dart';

class MySignupPage extends StatefulWidget {
  const MySignupPage({super.key});

  @override
  State<MySignupPage> createState() => _MySignupPageState();
}

class _MySignupPageState extends State<MySignupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'enter username'
              ),
            ),
            const SizedBox(height: 20),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'enter password'
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: (){
                Navigator.pushNamed(context,'/login');
              }, 
              child: const Text('Already have an account? Login!')
            ),
          ],
        ),
      ),
    );
  }
}