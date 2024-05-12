import 'package:flutter/material.dart';

import 'selected_schedule.dart';

class MySchedulePage extends StatefulWidget {
  final List<Map<String, dynamic>> schedules;

  const MySchedulePage({Key? key, required this.schedules}) : super(key: key);

  @override
  State<MySchedulePage> createState() => _MySchedulePageState();
}

class _MySchedulePageState extends State<MySchedulePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 231, 253),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
        child: ListView.builder(
          itemCount: widget.schedules.length,
          itemBuilder: (context, index) {
            final schedule = widget.schedules[index];
            final entriesWithValues = schedule.entries.where((entry) => entry.value.isNotEmpty);
            return ListTile(
              title: Text('Schedule ${index + 1}', style: const TextStyle(fontWeight: FontWeight.w500),),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (var entry in entriesWithValues)
                    Text('${entry.key}: ${entry.value}'),
                ],
              ),
              onTap: (){
                Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MySelectedSchedule(mySchedule: schedule),
                      ),
                    );
              },
            );
          },
        ),
      ),
    );
  }
}
