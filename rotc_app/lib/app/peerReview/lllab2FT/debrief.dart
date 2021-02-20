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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text('Adheres to Debrief Format'),
              ),
              TextFormField(
                maxLines: 3,
                controller: adheresToDebriefFormat,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onSaved: (String value) {},
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Radio(value: 20,
                    activeColor: Colors.black87,
                    groupValue: groupValueA,
                    onChanged: (int a) => buttonChangeA(a),),
                  Text('(O) 20 pt'),
                  Radio(value: 10,
                    activeColor: Colors.black87,
                    groupValue: groupValueA,
                    onChanged: (int a) => buttonChangeA(a),),
                  Text('(S) 10 pt'),
                  Radio(value: 0,
                    activeColor: Colors.black87,
                    groupValue: groupValueA,
                    onChanged: (int a) => buttonChangeA(a),),
                  Text('(U) 0 pt'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text('Receptive to Feedback'),
                  ),
                  TextFormField(
                    maxLines: 3,
                    controller: receptiveToFeedback,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (String value) {},
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Radio(value: 20,
                        activeColor: Colors.black87,
                        groupValue: groupValueB,
                        onChanged: (int b) => buttonChangeB(b),),
                      Text('(O) 20 pt'),
                      Radio(value: 10,
                        activeColor: Colors.black87,
                        groupValue: groupValueB,
                        onChanged: (int b) => buttonChangeB(b),),
                      Text('(S) 10 pt'),
                      Radio(value: 0,
                        activeColor: Colors.black87,
                        groupValue: groupValueB,
                        onChanged: (int b) => buttonChangeB(b),),
                      Text('(U) 0 pt'),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text('Improvement Oriented'),
                      ),
                      TextFormField(
                        maxLines: 3,
                        controller: improvementOriented,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (String value) {},
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Radio(value: 20,
                            activeColor: Colors.black87,
                            groupValue: groupValueC,
                            onChanged: (int c) => buttonChangeC(c),),
                          Text('(O) 20 pt'),
                          Radio(value: 10,
                            activeColor: Colors.black87,
                            groupValue: groupValueC,
                            onChanged: (int c) => buttonChangeC(c),),
                          Text('(S) 10 pt'),
                          Radio(value: 0,
                            activeColor: Colors.black87,
                            groupValue: groupValueC,
                            onChanged: (int c) => buttonChangeC(c),),
                          Text('(U) 0 pt'),
                        ],
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
