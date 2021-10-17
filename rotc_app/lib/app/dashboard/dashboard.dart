import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';

/*
* Author: Mac-Rufus O. Umeokolo
* This page is for the dashboard UI.
* it has all the codes for the dashboard UI and all the posting features
* */

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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
    } catch (e) {}
  }

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
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
        visible: isCadre == true,
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
      body: Container(
        decoration: BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topRight,
            end: Alignment(0.3, 0),
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
            colors: [
              // Colors are easy thanks to Flutter's Colors class.
              Colors.white,
              Colors.lightBlue,
            ],
          ),
        ),
        child: Scrollbar(
          controller: ScrollController(),
          child: StreamBuilder(
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

                      if (isCadre == true) {
                        return Dismissible(
                          onDismissed: (swipe) {
                            if (isCadre == true) {
                              deleteTasks(docSnap['DocumentName']);
                              deleteTasks(docSnap['DocumentURL']);
                            }
                          },
                          direction: DismissDirection.endToStart,
                          key: Key(docSnap['DocumentName']),
                          child: Card(
                            color: Colors.lightBlue[50],
                            elevation: 2,
                            margin: EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: ListTile(
                              title: Text(
                                docSnap['DocumentName'],
                              ),
                              onTap: () {
                                _launchURL(docSnap['DocumentURL']);
                              },
                            ),
                          ),
                          background: Container(
                            color: Colors.red[200],
                            child: Icon(Icons.cancel),
                          ),
                        );
                      } else
                        return Dismissible(
                          onDismissed: (none) {},
                          direction: DismissDirection.none,
                          key: Key(docSnap['DocumentName']),
                          child: Card(
                            color: Colors.lightBlue[50],
                            elevation: 2,
                            margin: EdgeInsets.all(8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: ListTile(
                              title: Text(
                                docSnap['DocumentName'],
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black,
                                ),
                              ),
                              onTap: () {
                                _launchURL(docSnap['DocumentURL']);
                              },
                            ),
                          ),
                        );
                    },
                  );
                } else if (snapshots.connectionState ==
                    ConnectionState.waiting) {
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
        ),
      ),
    );
  }
}
