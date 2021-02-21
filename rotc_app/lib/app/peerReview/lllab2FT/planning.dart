import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../peerReviewLanding.dart';
/*
 Author: Kyle Serruys
  This class is the Planning page of our peer review
 */

class Planning extends StatefulWidget {
  Planning() : super();

  @override
  PlanningState createState() => PlanningState();
}

class PlanningState extends State<Planning>{
  TextEditingController teamOrganization = TextEditingController();
  TextEditingController outsidePreparation = TextEditingController();
  TextEditingController missionFocus = TextEditingController();
  TextEditingController creativity = TextEditingController();

  CollectionReference planning = FirebaseFirestore.instance.collection('planning');
  CollectionReference planningScores = FirebaseFirestore.instance.collection('planningScores');

  Future<void> peerReviewPlanning() {
    return planning.add({
      'teamOrganization': teamOrganization.text,
      'outsidePreparation': outsidePreparation.text,
      'missionFocus': missionFocus.text,
      'creativity': creativity.text,
    });
  }

  Future<void> peerReviewPlanningScores() {
    return planningScores.add({
      'teamOrganizationScore': groupValueA,
      'outsidePreparationScore': groupValueB,
      'missionFocusScore': groupValueC,
      'creativityScore': groupValueD,
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
          title: Text('Planning'),
          actions: <Widget>[
      new IconButton(
      icon: new Icon(Icons.logout),
      onPressed: signOut,

    ),
    ],
      ),

    body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Center(

          //Team Organization
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Text('Team Organization'),
        ),
          Container(
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 200.0,
                child: TextFormField(
                  maxLines: 5,
                  controller: teamOrganization,
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

              //Outside Preparation
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text('Outside Preparation'),
                  ),
                  Container(
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 200.0,
                          child: TextFormField(
                            maxLines: 5,
                            controller: outsidePreparation,
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

                  //Mission Focus
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text('Mission Focus'),
                      ),
                      Container(
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 200.0,
                              child: TextFormField(
                                maxLines: 5,
                                controller: missionFocus,
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

                      //Creativity
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Text('Creativity'),
                          ),
                          Container(
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 200.0,
                                  child: TextFormField(
                                    maxLines: 5,
                                    controller: creativity,
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
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Container(
                                child: ElevatedButton(
                                  child: Text('Submit'),
                                  onPressed: () async {
                                    await peerReviewPlanningScores();
                                    await peerReviewPlanning();
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
          ],
        ),
        ),
        ),
    );
  }
}
