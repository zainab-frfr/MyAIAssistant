import 'package:flutter/material.dart';
import 'add_constraints.dart';


class CreateTask {
  static Widget build(BuildContext context, TextEditingController taskInputController, List<String> items) {
    return AlertDialog(
      title: const Text("Enter Task"),
      content: Padding(
        padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
        child: TextField(
          controller: taskInputController,
          // decoration: InputDecoration(),
        ),
      ),
      actions: <Widget>[
        SizedBox(
          height: 30,
          width: 80,
          child: FloatingActionButton(
            elevation: 2.0,
            backgroundColor: const Color.fromARGB(255, 183, 248, 185),
            onPressed: () async {
              String enteredText = taskInputController.text;
              taskInputController.clear();
              
              List<String> constraint = await showDialog(
                context: context, 
                builder: (BuildContext context) {
                  return AddConstraints.build(context, items);
                }
              );
              List<String> task = [enteredText];
              task.addAll(constraint);
              // ignore: use_build_context_synchronously
              Navigator.of(context).pop(task);

              
            },
            child: const Text('OK'),
          ),
        ),
        SizedBox(
          height: 30,
          width: 80,
          child: FloatingActionButton(
            elevation: 2.0,
            backgroundColor: const Color.fromARGB(255, 251, 151, 144),
            onPressed: () {
              taskInputController.clear();
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ),
      ],
    );
  }
}
