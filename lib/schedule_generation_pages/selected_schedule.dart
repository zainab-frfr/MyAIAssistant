import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ignore: must_be_immutable
class MySelectedSchedule extends StatefulWidget {
  Map<String, dynamic> mySchedule;

  // Default constructor with required parameter
  MySelectedSchedule({super.key, required this.mySchedule});

  // Named constructor without required parameter
  MySelectedSchedule.withoutSchedule({this.mySchedule = const {}, Key? key})
      : super(key: key);

  @override
  State<MySelectedSchedule> createState() => _MySelectedScheduleState();
}

class _MySelectedScheduleState extends State<MySelectedSchedule> {
  late Map<String, dynamic> mySchedule;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Load mySchedule only if it's called from the withoutSchedule constructor
    if (widget.mySchedule.isEmpty) {
      loadScheduleData();
    } else {
      mySchedule = Map<String, dynamic>.from(widget.mySchedule);
    }
    _startLoading();
  }

  void _startLoading() {
    // Show loading indicator
    setState(() {
      _isLoading = true;
    });

    // Hide loading indicator after 1 second
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Future<void> loadScheduleData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DatabaseReference userRef =
          FirebaseDatabase.instance.ref().child('users').child(user.uid);
      userRef.child('mySchedule').once().then((DatabaseEvent event) {
        if (event.snapshot.value != null) {
          Map<dynamic, dynamic> receivedData =
              event.snapshot.value as Map<dynamic, dynamic>;
          List keys = receivedData.keys.toList();

          Map<String, dynamic> orderedKeys;
          if (keys.contains('1:30')) {
            orderedKeys = {
              '1:00': '',
              '1:30': '',
              '2:00': '',
              '2:30': '',
              '3:00': '',
              '3:30': '',
              '4:00': '',
              '4:30': '',
              '5:00': '',
              '5:30': '',
              '6:00': '',
              '6:30': '',
              '7:00': '',
              '7:30': '',
              '8:00': '',
              '8:30': '',
              '9:00': '',
              '9:30': '',
              '10:00': '',
              '10:30': '',
              '11:00': '',
              '11:30': '',
              '12:00': '',
              '12:30': '',
              '13:00': '',
              '13:30': '',
              '14:00': '',
              '14:30': '',
              '15:00': '',
              '15:30': '',
              '16:00': '',
              '16:30': '',
              '17:00': '',
              '17:30': '',
              '18:00': '',
              '18:30': '',
              '19:00': '',
              '19:30': '',
              '20:00': '',
              '20:30': '',
              '21:00': '',
              '21:30': '',
              '22:00': '',
              '22:30': '',
              '23:00': '',
              '23:30': '',
              '24:00': ''
            };
          } else {
            orderedKeys = {
              '1:00': '',
              '2:00': '',
              '3:00': '',
              '4:00': '',
              '5:00': '',
              '6:00': '',
              '7:00': '',
              '8:00': '',
              '9:00': '',
              '10:00': '',
              '11:00': '',
              '12:00': '',
              '13:00': '',
              '14:00': '',
              '15:00': '',
              '16:00': '',
              '17:00': '',
              '18:00': '',
              '19:00': '',
              '20:00': '',
              '21:00': '',
              '22:00': '',
              '23:00': '',
              '24:00': ''
            };
          }

          Map<String, dynamic> orderedSchedule = {};
          for (var entry in orderedKeys.entries) {
            String key = entry.key;
            if (receivedData.containsKey(key)) {
              orderedSchedule[key] = receivedData[key];
            }
          }

          setState(() {
            mySchedule = orderedSchedule;
            widget.mySchedule = mySchedule;
          });
        }
      }).catchError((error) {
        print("Error loading schedule data: $error");
      });
    }
  }

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
              Center(
                child: Visibility(
                  visible: _isLoading,
                  child: CircularProgressIndicator(),
                ),
              ),
              if (widget.mySchedule.isEmpty && !_isLoading)
                const Expanded(
                  child: Center(
                    child: Text("No schedule created..."),
                  ),
                ),
              if (widget.mySchedule.isNotEmpty && !_isLoading)
                Expanded(
                  child: ListView.builder(
                    itemCount: widget.mySchedule.length,
                    itemBuilder: (context, index) {
                      final entry = widget.mySchedule.entries.elementAt(index);
                      return ListTile(
                        title: Container(
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 226, 210, 255),
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
