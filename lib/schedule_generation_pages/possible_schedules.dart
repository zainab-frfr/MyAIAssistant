import 'package:flutter/material.dart';

class MySchedulePage extends StatefulWidget {
  const MySchedulePage({super.key});

  @override
  State<MySchedulePage> createState() => _MySchedulePageState();
}

class _MySchedulePageState extends State<MySchedulePage> {
  final List<List<String>> schedules = [['option 1','run'],['option 2','eat'],['option 3','play']];
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor:Color.fromARGB(255, 246, 231, 253),
      );
  }
}