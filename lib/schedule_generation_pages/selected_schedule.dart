import 'package:flutter/material.dart';

class MySelectedSchedule extends StatefulWidget {
  final Map<String, dynamic> mySchedule;

  // Default constructor with required parameter
  const MySelectedSchedule({super.key, required this.mySchedule});

  // Named constructor without required parameter
   const MySelectedSchedule.withoutSchedule({this.mySchedule = const {}, Key? key})
      : super(key: key);

  @override
  State<MySelectedSchedule> createState() => _MySelectedScheduleState();
}

class _MySelectedScheduleState extends State<MySelectedSchedule> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 246, 231, 253),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 211, 196, 237),
          title: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "Today's Schedule",
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 20.0),
                ),
              ],
            ),
          ),
        ),
        drawer: Drawer(
          elevation: 5.0,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                padding: EdgeInsets.symmetric(vertical: 65.0, horizontal: 10.0),
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 211, 196, 237),
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    //color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ListTile(
                title: const Text('My Schedule'),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/mySchedule');
                },
              ),
              ListTile(
                title: const Text('Create New Schedule'),
                onTap: () {
                  Navigator.popAndPushNamed(context, '/home');
                },
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30.0),
          child: Column(
            children: [
              if (widget.mySchedule.isEmpty)
                const Expanded(
                  child: Center(
                    child: Text("No schedule created..."),
                  ),
                ),
              if (widget.mySchedule.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.mySchedule.length,
                    itemBuilder: (context, index) {
                      final entry = widget.mySchedule.entries.elementAt(index);
                      return ListTile(
                        title: Container(
                          decoration:const BoxDecoration(
                            color:  Color.fromARGB(255, 226, 210, 255),
                          ),
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                entry.key,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Color.fromARGB(255, 82, 81, 81),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                entry.value,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  color: Color.fromARGB(255, 82, 81, 81),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ));
  }
}
