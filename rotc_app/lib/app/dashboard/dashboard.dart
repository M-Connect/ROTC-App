import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:googleapis/fcm/v1.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

/*
Author: Mac-Rufus O. Umeokolo

**/

class Dashboard extends StatefulWidget {

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  /// initializing string to null
  String userInput = '';
  String userURLInput = '';

  bool isCadre;

  @override
  void initState() {
    super.initState();
    getBool();
    //  initSliderValue();
  }


  getBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isCadre = prefs.getString('isCadre') == 'true';
    });
  }

  createTasks() async {
    var url = userURLInput.toString();
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('dashboardUrls').doc(userInput);
    Map<String, dynamic> tasks = {
      "DocumentName": userInput,
      "DocumentURL": url,
    };
    await docRef.set(tasks).whenComplete(() {
      print("$userInput sent");
    });
  }

  deleteTasks(task) {
    try {
      var url = userURLInput.toString();
      DocumentReference docRef =
      FirebaseFirestore.instance.collection('dashboardUrls').doc(task);

      docRef.delete().whenComplete(() {
        print("$task deleted.");
      });
    }catch(e){

    }
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceWebView: true,
        enableJavaScript: true,
      );
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Visibility(
        visible: isCadre = true,
        child: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text("Upload Document URL"),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          Text('Document Name'),
                          SizedBox(height: 10),
                          TextFormField(
                            onChanged: (String documentTask) {
                              userInput = documentTask;
                            },
                            decoration: new InputDecoration(
                              labelText: '\"Document Name\"',
                            ),
                            toolbarOptions: ToolbarOptions(
                              paste: true,
                              cut: true,
                              copy: true,
                              selectAll: true,
                            ),
                          ),
                          SizedBox(height: 10),

                          TextField(
                            onChanged: (String documentUrlTask) {
                              userURLInput = documentUrlTask;
                            },

                            decoration: new InputDecoration(
                              labelText: '\"Document URL\"',
                            ),

                            toolbarOptions: ToolbarOptions(
                              paste: true,
                              cut: true,
                              copy: true,
                              selectAll: true,
                            ),
                          ),

                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          createTasks();

                          Navigator.of(context).pop();
                        },
                        child: Text("Post"),
                      ),
                    ],
                  );
                });
          },
          child: Icon(
            Icons.upload_outlined,
            color: Colors.white,
          ),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("dashboardUrls")
              .snapshots(),
          builder: (context, snapshots) {
            if (snapshots.connectionState == ConnectionState.active) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshots.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot docSnap = snapshots.data.docs[index];
                  return Dismissible(
                    onDismissed: (swipe) {
                      deleteTasks(docSnap['DocumentName']);
                      deleteTasks(docSnap['DocumentURL']);
                    },
                    key: Key(docSnap['DocumentName']),
                    child: Card(
                      color: Colors.lightBlueAccent,
                      elevation: 2,
                      margin: EdgeInsets.all(8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: ListTile(
                        title: Text(docSnap['DocumentName']),
                        onTap: () {
                          _launchURL(docSnap['DocumentURL']);
                        },
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
                      child: Icon(Icons.warning_amber_sharp),
                    ),
                    Text('Error loading tasks.')
                  ],
                ),
              );
            }
          }),


    );

  }
}
