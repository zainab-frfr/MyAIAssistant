import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_ai_assistant_frontend/home.dart';
import 'package:my_ai_assistant_frontend/login_signup/login.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),  //tells if user is logged in or not 
        builder: (context, snapshot){
          // user logged in
          if (snapshot.hasData) {
            return const Home();
          }
          //user not logged in 
          else{
            return const MyLoginPage();
          }
        }
      ),
    );
  }
}