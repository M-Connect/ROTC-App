import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// Author: Christine Thomas
// These classes allow the user to add  and delete tasks for the day.
/// TODO: turn task cards into expansion panels

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {

  /// initializing string to null
  String userInput = '';
  DateTime timeStamp;

  createTasks() async {
    DocumentReference docRef = FirebaseFirestore.instance.collection('ToDoList')
        .doc(userInput);
    Map<String, dynamic> items = {
      "item": userInput,
      "timeStamp": timeStamp,
    };
    await docRef.set(items).whenComplete(() {
      print("$userInput sent");
      print("$timeStamp sent");
    });

  }

  deleteItems(item){
    DocumentReference docRef = FirebaseFirestore.instance.collection('ToDoList')
        .doc(item);

    docRef.delete().whenComplete(() {
      print("$item deleted.");
    });  }
/*  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    taskList.add("Finish coding");
    taskList.add("Task 1 failed");
  }*/

  /// trying to test some stuff out
  DateTime aprilFirst = DateTime.utc(2019, 4, 1);
  DateTime marchThirty = DateTime.utc(2019, 3, 30);
  DateTime marchThirtyFirst = DateTime.utc(2019, 3, 31);


var now = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily To-Do List"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text("New Item"),
                  content: TextField(
                    onChanged: (String newTask) {
                      userInput = newTask;
                      timeStamp = DateTime.now();
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
          stream: FirebaseFirestore.instance.collection("ToDoList").snapshots(),
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.active) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshots.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot docSnap = snapshots.data.docs[index];
                  if(snapshots.data.docs.length > 0 && timeStamp != null && timeStamp.difference(now).inDays > 0) {
                    var time1 = DateTime.now();
                    var time2 = time1.add(const Duration(days: 50));
                    var difference = time1
                        .difference(time2)
                        .inDays;
                    print('$difference');
                    FirebaseFirestore.instance.collection("ToDoList")
                        .snapshots()
                        .forEach((element) {
                      deleteItems(element);
                    });
                  }
                  return Dismissible(
                    onDismissed: (swipe){
                      deleteItems(docSnap['item']);
                    },
                    key: Key(docSnap['item']),
                    child: Card(
                      elevation: 2,
                      margin: EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: ListTile(
                        title: Text(docSnap['item']),
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
                        'Error loading To-do List.'
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
