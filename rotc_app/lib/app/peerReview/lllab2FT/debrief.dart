import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../peerReviewLanding.dart';

/*
 Author: Kyle Serruys
  This class is the Debrief page of our peer review
 */
class Debrief extends StatefulWidget {
Debrief() : super();

@override
DebriefState createState() => DebriefState();
}
class DebriefState extends State<Debrief> {
  TextEditingController adheresToDebriefFormat = TextEditingController();
  TextEditingController receptiveToFeedback = TextEditingController();
  TextEditingController improvementOriented = TextEditingController();

  CollectionReference debrief = FirebaseFirestore.instance.collection('debrief');
  CollectionReference debriefScores = FirebaseFirestore.instance.collection('debriefScores');

  Future<void> peerReviewDebrief() {
    return debrief.add({
      'adheresToDebriefFormat': adheresToDebriefFormat.text,
      'receptiveToFeedback': receptiveToFeedback.text,
      'improvementOriented': improvementOriented.text,
    });
  }

  Future<void> peerReviewDebriefScores(){
    return debriefScores.add({
      'debriefFormatScore': groupValueA,
      'feedbackScore': groupValueB,
      'improvementOrientedScore': groupValueC,
    });
  }

  int groupValueA;
  int groupValueB;
  int groupValueC;

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Debrief'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
            onPressed: signOut,

          ),
        ],),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Form(

          //Adheres To Debrief Format
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text('Adheres to Debrief Format'),
              ),
              Container(
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 200.0,
                      child: TextFormField(
                        maxLines: 5,
                        controller: adheresToDebriefFormat,
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

              //Receptive to Feedback
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text('Receptive to Feedback'),
                  ),
                  Container(
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 200.0,
                          child: TextFormField(
                            maxLines: 5,
                            controller: receptiveToFeedback,
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

                  //Improvement-Oriented
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text('Improvement-Oriented'),
                      ),
                      Container(
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 200.0,
                              child: TextFormField(
                                maxLines: 5,
                                controller: improvementOriented,
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                child: ElevatedButton(
                                  child: Text('Submit'),
                                  onPressed: () async {
                                    await peerReviewDebriefScores();
                                    await peerReviewDebrief();
                                    navigation.currentState
                                        .pushNamed('/peerReviewLLAB2FT');
                                  },
                                ),
                              ),
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
