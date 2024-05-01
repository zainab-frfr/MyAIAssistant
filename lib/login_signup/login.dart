import 'package:flutter/material.dart';
// import 'signup.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key});

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
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
                Navigator.pushNamed(context,'/signup');
              }, 
              child: const Text('Don\'t have an account? Sign up!')
            ),
          ],
        ),
      ),
    );
  }
}