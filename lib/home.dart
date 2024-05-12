import 'package:flutter/material.dart';
import 'package:http/http.dart'
    as http; //for making http requests to the backend
import 'dart:convert'; // for encoding and decoding json data
import 'schedule_generation_pages/possible_schedules.dart';
import 'task_creation_pages/create_task.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> variables = [];
  List<List> allTasks = [];
  List<String> removed = [];

  List<Map<String, dynamic>> allPossibleSchedules = [];

  TextEditingController _taskInputController = TextEditingController();

  List<String> daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday'
  ];

  List<String> timeSlotSelected = [
    'Day divided into one hour slots',
    'Day divided into half hour slots',
  ];
  int pointer = 0;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    const String url =
        'http://zainabfrfr.pythonanywhere.com/initialization'; // this is the URL of the endpoint to which backend requests are made

    final http.Response response = await http.post(
      //defined variable response to store response returned by HTTP post request
      Uri.parse(url),
      headers: <String, String>{
        // defined a map as a header. the map has keys and values both of type string
        'Content-Type':
            'application/json; charset=UTF-8', // indicates that content being sent in body will be in json format and encoded using UTF-8 character encoding
      },
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<String> variablesList =
          List<String>.from(responseData['variables']);

      setState(() {
        variables = variablesList;
      });
    } else {
      print(response.statusCode);
    }
  }

  Future<void> _changeTimeSlots() async {
    //async operation that returns nothing
    const String url =
        'http://zainabfrfr.pythonanywhere.com/variables'; // this is the URL of the endpoint to which backend requests are made
    final Map<String, String> data = {
      'timeslot': timeSlotSelected[pointer],
    };

    final http.Response response = await http.post(
      //defined variable response to store response returned by HTTP post request
      Uri.parse(url),
      headers: <String, String>{
        // defined a map as a header. the map has keys and values both of type string
        'Content-Type':
            'application/json; charset=UTF-8', // indicates that content being sent in body will be in json format and encoded using UTF-8 character encoding
      },
      body: jsonEncode(data),
    );
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<String> variablesList =
          List<String>.from(responseData['variables']);

      setState(() {
        variables = variablesList;
      });
    } else {
      print(response.statusCode);
    }
  }

  Future<void> _generateSchedule() async {
    const String url =
        'http://zainabfrfr.pythonanywhere.com/schedulesGenerate'; // this is the URL of the endpoint to which backend requests are made
    final Map<String, dynamic> data = {
      'tasks': allTasks,
    };

    final http.Response response = await http.post(
      //defined variable response to store response returned by HTTP post request
      Uri.parse(url),
      headers: <String, String>{
        // defined a map as a header. the map has keys and values both of type string
        'Content-Type':
            'application/json; charset=UTF-8', // indicates that content being sent in body will be in json format and encoded using UTF-8 character encoding
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      // print("json data received: ${responseData['schedules']}");
      // print("response size ${response.bodyBytes.length}");
      final List<Map<String, dynamic>> aPS = [];

      // adding all non-empty assignments to the list of possible schedules
      for (var schedule in responseData['schedules']) {
        final orderedSchedule = <String, dynamic>{};
        bool isEmpty = true; // Flag to track if the schedule is empty
        for (var key in variables) {
          if (schedule.containsKey(key)) {
            orderedSchedule[key] = schedule[key];
            isEmpty = false; // If any key exists, schedule is not empty
          } else {
            orderedSchedule[key] =
                ''; // Use default value '' if the key doesn't exist
          }
        }
        if (!isEmpty) {
          // Add schedule to aPS only if it's not empty
          aPS.add(orderedSchedule);
        }
      }

      setState(() {
        allPossibleSchedules = aPS;
      });

      print(allPossibleSchedules);
    } else {
      print("Unsuccessful Post Request ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 231, 253),

      // app bar on which day and date is displayed

      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 211, 196, 237),
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                daysOfWeek[DateTime.now().weekday - 1],
                style: const TextStyle(
                    fontWeight: FontWeight.w900, fontSize: 20.0),
              ),
              Text(
                "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),

      //side menu
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
                // Handle item 1 tap
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

      // bottom bar on which all the buttons are displayed

      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
        child: BottomAppBar(
          color: const Color.fromARGB(255, 211, 196, 237),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //time slot button
              FloatingActionButton(
                tooltip: 'Time Slot Division!',
                elevation: 3.0,
                child: const Icon(Icons.av_timer_rounded),
                onPressed: () {
                  pointer = (pointer + 1) % timeSlotSelected.length;
                  print(timeSlotSelected[pointer]);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(timeSlotSelected[pointer]),
                      duration: const Duration(seconds: 1),
                    ),
                  );

                  _changeTimeSlots();
                  //setState((){});
                },
              ),
              const SizedBox(
                width: 50,
              ),
              //add task button
              FloatingActionButton(
                tooltip: 'Add Task!',
                elevation: 3.0,
                child: const Icon(Icons.add),
                onPressed: () async {
                  List<String> enteredTask = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CreateTask.build(
                            context, _taskInputController, variables);
                      });
                  print('Entered Task: $enteredTask');
                  setState(() {
                    allTasks.add(enteredTask);
                  });
                },
              ),
              const SizedBox(
                width: 50,
              ),
              //generate schedule button
              FloatingActionButton(
                tooltip: 'Generate Schedule!',
                elevation: 3.0,
                child: const Icon(Icons.list_alt_rounded),
                onPressed: () {
                  _generateSchedule().then((_) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            MySchedulePage(schedules: allPossibleSchedules),
                      ),
                    );
                  });
                },
              ),
            ],
          ),
        ),
      ),

      //body in the middle where list of tasks added will be displayed

      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30.0),
        child: Column(
          children: [
            if (allTasks.isNotEmpty) // Show tasks if there are any
              Flexible(
                child: ListView.builder(
                  itemCount: allTasks.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: Key(allTasks[index]
                          .toString()), // Unique key for each item
                      onDismissed: (direction) {
                        setState(() {
                          removed = allTasks.removeAt(index)
                              as List<String>; // Remove the item from the list
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text("Task deleted"),
                            duration: const Duration(seconds: 1),
                            action: SnackBarAction(
                              label: "Undo",
                              onPressed: () {
                                setState(() {
                                  allTasks.insert(index, removed);
                                });
                              },
                            ),
                          ),
                        );
                      },
                      background: Container(
                        width: double.infinity,
                        height: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: const Color.fromARGB(255, 251, 151, 144)),
                        child: const Center(
                            child: Icon(
                          Icons.delete,
                          size: 30.0,
                        )), // Delete icon
                      ),
                      child: ListTile(
                        title: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 226, 210, 255),
                            borderRadius: BorderRadius.circular(10.0),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 166, 165, 165)
                                    .withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 2),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(
                              15.0), // Padding inside the tile
                          child: Text(
                            allTasks[index].join(
                                '\n'), // Join the elements of each task list
                            style: const TextStyle(
                              fontSize: 16.0, // Font size
                              color: Color.fromARGB(255, 82, 81, 81),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            if (allTasks.isEmpty) // Show text if there are no tasks
              const Expanded(
                child: Center(
                  child: Text("Let's get to planning..."),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
