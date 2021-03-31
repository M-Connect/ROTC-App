import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Author: Christine Thomas
// These classes allow the user to add  and delete tasks for the day.
/// TODO: turn task cards into expansion panels

class Tasks extends StatefulWidget {
  @override
  _TasksState createState() => _TasksState();
}

class _TasksState extends State<Tasks> {

  /// initializing string to null
  String userInput = '';

  createTasks() async {
    DocumentReference docRef = FirebaseFirestore.instance.collection('Tasks')
        .doc(userInput);
    Map<String, dynamic> tasks = {
      "titleOfTask": userInput,
    };
    await docRef.set(tasks).whenComplete(() {
      print("$userInput sent");
    });

  }

  deleteTasks(task){
    DocumentReference docRef = FirebaseFirestore.instance.collection('Tasks')
        .doc(task);

    docRef.delete().whenComplete(() {
      print("$task deleted.");
    });  }
/*  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskList.add("Finish coding");
    taskList.add("Task 1 failed");
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tasks for the Day"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("Add a new task"),
                  content: TextField(
                    onChanged: (String newTask) {
                      userInput = newTask;
                    },
                  ),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        createTasks();

                        Navigator.of(context).pop();
                      },
                      child: Text("ADD"),
                    ),
                  ],
                );
              });
        },
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder (
          stream: FirebaseFirestore.instance.collection("Tasks").snapshots(),
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.active) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshots.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot docSnap = snapshots.data.docs[index];
                  return Dismissible(
                    onDismissed: (swipe){
                      deleteTasks(docSnap['titleOfTask']);
                    },
                    key: Key(docSnap['titleOfTask']),
                    child: Card(
                      elevation: 2,
                      margin: EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: ListTile(
                        title: Text(docSnap['titleOfTask']),
                      ),
                    ),
                  );
                },
              );
            } else if (snapshots.connectionState == ConnectionState.waiting) {
              return Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            } else {
              return Container(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(
                          Icons.warning_amber_sharp
                      ),
                    ),
                    Text(
                        'Error loading tasks.'
                    )
                  ],
                ),
              );
            }
          }

      ),
    );

  }
}
