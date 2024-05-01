import 'package:flutter/material.dart';
import 'create_task.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> items = ['Option 1', 'Option 2', 'Option 3'];
  List<List> allTasks = [];
  List<String> removed = [];

  TextEditingController _taskInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<String> daysOfWeek = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday'
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 246, 231, 253),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 211, 196, 237),
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                daysOfWeek[DateTime.now().weekday - 1],
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
              ),
              Text(
                "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: BottomAppBar(
          color: const Color.fromARGB(255, 211, 196, 237),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FloatingActionButton(
                tooltip: 'Add Task!',
                elevation: 3.0,
                child: const Icon(Icons.add),
                onPressed: () async {
                  List<String> enteredTask = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return CreateTask.build(
                            context, _taskInputController, items);
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
              FloatingActionButton(
                tooltip: 'Generate Schedule!',
                elevation: 3.0,
                child: const Icon(Icons.list_alt_rounded),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
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
                            borderRadius: BorderRadius.circular(
                                10.0), // Border radius to round the corners
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 198, 198, 198)
                                    .withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 3,
                                offset: const Offset(0, 2), // Shadow position
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
