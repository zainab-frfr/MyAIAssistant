import 'package:flutter/material.dart';
import 'login_signup/login.dart';
import 'login_signup/signup.dart';
import 'home.dart';
import 'schedule_generation_pages/selected_schedule.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 165, 113, 255)),
        useMaterial3: true,
      ),
      initialRoute: '/home',
      routes: {
        '/home':(context) => const Home(),
        '/login':(context) => const MyLoginPage(),
        '/signup' :(context) => const MySignupPage(),
        '/mySchedule':(context) => MySelectedSchedule.withoutSchedule(),
      },
    );
  }
}

