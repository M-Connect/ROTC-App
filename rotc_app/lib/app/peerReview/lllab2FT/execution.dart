import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';
import '../peerReviewLanding.dart';
/*
 Author: Kyle Serruys
  This class is the Execution page of our peer review
 */

class Execution extends StatefulWidget {
  Execution() : super();

  @override
  ExecutionState createState() => ExecutionState();
}

class ExecutionState extends State<Execution>{
  TextEditingController timeManagement = TextEditingController();
  TextEditingController resourcesManagement = TextEditingController();
  TextEditingController flexibility = TextEditingController();
  TextEditingController missionSuccess = TextEditingController();

  CollectionReference execution = FirebaseFirestore.instance.collection('execution');
  CollectionReference executionScores = FirebaseFirestore.instance.collection('/execution').doc().collection('executionScores');

  Future<void> peerReviewExecution() {
    return execution.add({
      'timeManagement': timeManagement.text,
      'resourcesManagement': resourcesManagement.text,
      'flexibility': flexibility.text,
      'missionSuccess': missionSuccess.text,
    });
  }

  Future<void> peerReviewExecutionScores() {
    return executionScores.add({
      'timeManagementScore': groupValueA,
      'resourcesManagementScore': groupValueB,
      'flexibilityScore': groupValueC,
      'missionSuccessScore': groupValueD,
    });
  }

  int groupValueA;
  int groupValueB;
  int groupValueC;
  int groupValueD;

  void buttonChangeA(int button) {
    setState(() {
      if (button == 20) {
        groupValueA = 20;
      } else if (button == 10) {
        groupValueA = 10;
      } else if (button == 0) {
        groupValueA = 0;
      }
    });
  }

  void buttonChangeB(int button) {
    setState(() {
      if (button == 20) {
        groupValueB = 20;
      } else if (button == 10) {
        groupValueB = 10;
      } else if (button == 0) {
        groupValueB = 0;
      }
    });
  }

  void buttonChangeC(int button) {
    setState(() {
      if (button == 20) {
        groupValueC = 20;
      } else if (button == 10) {
        groupValueC = 10;
      } else if (button == 0) {
        groupValueC = 0;
      }
    });
  }

  void buttonChangeD(int button) {
    setState(() {
      if (button == 20) {
        groupValueD = 20;
      } else if (button == 10) {
        groupValueD = 10;
      } else if (button == 0) {
        groupValueD = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            navigation.currentState.pushNamed('/peerReviewLLAB2FT');
          },
        ),title: Text('Execution'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
            onPressed: (){},

          ),
        ],),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Form(

          //Time Management
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text('Time Management'),
                ),
                Container(
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 200.0,
                        child: TextFormField(
                          maxLines: 5,
                          controller: timeManagement,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: const EdgeInsets.symmetric(vertical: 75.0),
                          ),
                          onSaved: (String value) {},
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                                title: const Text('20 pt'),
                                leading: Radio(value: 20, activeColor: Colors.black87, groupValue: groupValueA, onChanged: (int a) => buttonChangeA(a),)
                            ),
                            ListTile(
                                title: const Text('15 pt'),
                                leading: Radio(value: 15, activeColor: Colors.black87, groupValue: null, onChanged: null)
                            ),
                            ListTile(
                                title: const Text('10 pt'),
                                leading: Radio(value: 10, activeColor: Colors.black87, groupValue: groupValueA, onChanged: (int a) => buttonChangeA(a),)
                            ),
                            ListTile(
                                title: const Text('5 pt'),
                                leading: Radio(value: 5, activeColor: Colors.black87, groupValue: null, onChanged: null)
                            ),
                            ListTile(
                              title: const Text('0 pt'),
                              leading: Radio(value: 0, activeColor: Colors.black87, groupValue: groupValueA, onChanged: (int a) => buttonChangeA(a),),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                //Resources Management
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text('Resources Management'),
                    ),
                    Container(
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 200.0,
                            child: TextFormField(
                              maxLines: 5,
                              controller: resourcesManagement,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                contentPadding: const EdgeInsets.symmetric(vertical: 75.0),
                              ),
                              onSaved: (String value) {},
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ListTile(
                                    title: const Text('20 pt'),
                                    leading: Radio(value: 20, activeColor: Colors.black87, groupValue: groupValueB, onChanged: (int b) => buttonChangeB(b),)
                                ),
                                ListTile(
                                    title: const Text('15 pt'),
                                    leading: Radio(value: 15, activeColor: Colors.black87, groupValue: null, onChanged: null)
                                ),
                                ListTile(
                                    title: const Text('10 pt'),
                                    leading: Radio(value: 10, activeColor: Colors.black87, groupValue: groupValueB, onChanged: (int b) => buttonChangeB(b),)
                                ),
                                ListTile(
                                    title: const Text('5 pt'),
                                    leading: Radio(value: 5, activeColor: Colors.black87, groupValue: null, onChanged: null)
                                ),
                                ListTile(
                                  title: const Text('0 pt'),
                                  leading: Radio(value: 0, activeColor: Colors.black87, groupValue: groupValueB, onChanged: (int b) => buttonChangeB(b),),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    //Flexibility
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text('Flexibility'),
                        ),
                        Container(
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 200.0,
                                child: TextFormField(
                                  maxLines: 5,
                                  controller: flexibility,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    contentPadding: const EdgeInsets.symmetric(vertical: 75.0),
                                  ),
                                  onSaved: (String value) {},
                                ),
                              ),
                              SizedBox(
                                width: 150,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: <Widget>[
                                    ListTile(
                                        title: const Text('20 pt'),
                                        leading: Radio(value: 20, activeColor: Colors.black87, groupValue: groupValueC, onChanged: (int c) => buttonChangeC(c),)
                                    ),
                                    ListTile(
                                        title: const Text('15 pt'),
                                        leading: Radio(value: 15, activeColor: Colors.black87, groupValue: null, onChanged: null)
                                    ),
                                    ListTile(
                                        title: const Text('10 pt'),
                                        leading: Radio(value: 10, activeColor: Colors.black87, groupValue: groupValueC, onChanged: (int c) => buttonChangeC(c),)
                                    ),
                                    ListTile(
                                        title: const Text('5 pt'),
                                        leading: Radio(value: 5, activeColor: Colors.black87, groupValue: null, onChanged: null)
                                    ),
                                    ListTile(
                                      title: const Text('0 pt'),
                                      leading: Radio(value: 0, activeColor: Colors.black87, groupValue: groupValueC, onChanged: (int c) => buttonChangeC(c),),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Mission Success
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                              child: Text('Mission Success'),
                            ),
                            Container(
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 200.0,
                                    child: TextFormField(
                                      maxLines: 5,
                                      controller: missionSuccess,
                                      decoration: const InputDecoration(
                                        border: OutlineInputBorder(),
                                        contentPadding: const EdgeInsets.symmetric(vertical: 75.0),
                                      ),
                                      onSaved: (String value) {},
                                    ),
                                  ),
                                  SizedBox(
                                    width: 150,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        ListTile(
                                            title: const Text('20 pt'),
                                            leading: Radio(value: 20, activeColor: Colors.black87, groupValue: groupValueD, onChanged: (int d) => buttonChangeD(d),)
                                        ),
                                        ListTile(
                                            title: const Text('15 pt'),
                                            leading: Radio(value: 15, activeColor: Colors.black87, groupValue: null, onChanged: null)
                                        ),
                                        ListTile(
                                            title: const Text('10 pt'),
                                            leading: Radio(value: 10, activeColor: Colors.black87, groupValue: groupValueD, onChanged: (int d) => buttonChangeD(d),)
                                        ),
                                        ListTile(
                                            title: const Text('5 pt'),
                                            leading: Radio(value: 5, activeColor: Colors.black87, groupValue: null, onChanged: null)
                                        ),
                                        ListTile(
                                          title: const Text('0 pt'),
                                          leading: Radio(value: 0, activeColor: Colors.black87, groupValue: groupValueD, onChanged: (int d) => buttonChangeD(d),),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                ElevatedButton(
                                    child: Text('Prev'),
                                    onPressed: () async {
                                      navigation.currentState
                                          .pushNamed('/communication');
                                    },
                                  ),

                                ElevatedButton(
                                  child: Text('Save'),
                                  onPressed: () async {
                                    await peerReviewExecutionScores();
                                    await peerReviewExecution();

                                  },
                                ),
                                ElevatedButton(
                                  child: Text('Next'),
                                  onPressed: () async {
                                    navigation.currentState
                                        .pushNamed('/leadership');
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
        ),
      ),
    );
  }
}
