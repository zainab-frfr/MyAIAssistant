import 'package:flutter/material.dart';

class AddConstraints {

 
  
   static  build(
      BuildContext context, List<String> items) {
    
    List<String> constraint = [];

    return AlertDialog(
      title: const Text("Select one"),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            ListTile(
              title: const Text('No Constraints'),
              onTap: () {
                constraint.add('No Constraints');
                Navigator.of(context).pop(constraint); // Close dialog
              },
            ),
            ListTile(
              title: const Text('Time Range'),
              onTap: () async {
                constraint.add('Time Range');
                List<String> timeRange = await _showTimeRangeDialog(context, items);
                constraint.addAll(timeRange);
                // ignore: avoid_print
                print('$timeRange');

                // ignore: use_build_context_synchronously
                Navigator.of(context).pop(constraint); 
              },
            ),
            ListTile(
              title: const Text('Specific Time'),
              onTap: () async {
                constraint.add('Specific Time');
                
                String selectedTime = await _showTSpecificTimeDialog(context, items);
                constraint.add(selectedTime);

                 // ignore: avoid_print
                print(selectedTime);

                // ignore: use_build_context_synchronously
                Navigator.of(context).pop(constraint); 
              },
            ),
            ListTile(
              title: const Text('Multitask!'),
              onTap: () {
                constraint.add('Multitask!');
                Navigator.of(context).pop(constraint);
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future _showTimeRangeDialog(BuildContext context,List<String> items) {
      String? startTime = items.isNotEmpty ? items.first : null;
      String? endTime = items.isNotEmpty ? items.last : null;

      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                title: const Text("Select Time Range"),
                content: Container(
                  height: 220.0,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 60.0,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SingleChildScrollView(
                            child: DropdownButton(
                              value: startTime,
                              items: items.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? value) {
                                setState(() {
                                  startTime = value;
                                });
                              },
                            ),
                          ),
                          const SizedBox(
                            width: 30.0,
                          ),
                          const Text('to'),
                          const SizedBox(width: 30.0),
                          SingleChildScrollView(
                            child: DropdownButton(
                              value: endTime,
                              items: items.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (value) => {
                                print(endTime),
                                setState(() {
                                  endTime = value;
                                })
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      SizedBox(
                        height: 30,
                        width: 80,
                        child: FloatingActionButton(
                            elevation: 2.0,
                            child: const Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop([startTime!,endTime!]);
                            }),
                      )
                    ],
                  ),
                ),
              );
            });
          });
    }

Future _showTSpecificTimeDialog(BuildContext context, List<String> items) {
      String? selectedTime = items.isNotEmpty ? items.first : null;

      return showDialog(
          context: context,
          builder: (BuildContext context) {
            return StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                  title: const Text("Select Time Slot"),
                  content: Container(
                    height: 220.0,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 60.0,
                        ),
                        SingleChildScrollView(
                          child: DropdownButton(
                            value: selectedTime,
                            items: items.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? value) {
                              setState(() {
                                selectedTime = value;
                              });
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 50.0,
                        ),
                        SizedBox(
                          height: 30,
                          width: 80,
                          child: FloatingActionButton(
                              elevation: 2.0,
                              child: const Text('OK'),
                              onPressed: () {
                                Navigator.of(context).pop(selectedTime);
                              }),
                        )
                      ],
                    ),
                  ));
            });
          });
    }