import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';

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



  int groupValueA;
  int groupValueB;
  int groupValueC;

  void buttonChangeA(int button) {
    setState(() {
      if (button == 20) {
        groupValueA = 20;
      } else if (button == 15) {
        groupValueA = 15;
      } else if (button == 10) {
        groupValueA = 10;
      } else if (button == 5) {
        groupValueA = 5;
      } else if (button == 0) {
        groupValueA = 0;
      }
    });
  }

  void buttonChangeB(int button) {
    setState(() {
      if (button == 20) {
        groupValueB = 20;
      } else if (button == 15) {
        groupValueB = 15;
      } else if (button == 10) {
        groupValueB = 10;
      } else if (button == 5) {
        groupValueB = 5;
      } else if (button == 0) {
        groupValueB = 0;
      }
    });
  }

  void buttonChangeC(int button) {
    setState(() {
      if (button == 20) {
        groupValueC = 20;
      } else if (button == 15) {
        groupValueC = 15;
      } else if (button == 10) {
        groupValueC = 10;
      } else if (button == 5) {
        groupValueC = 5;
      } else if (button == 0) {
        groupValueC = 0;
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
        ),title: Text('Debrief'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
            onPressed: (){},

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
                 // mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 200.0,
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.top,
                        maxLength: 160,
                        maxLengthEnforced: true,
                        maxLines: 10,
                        controller: adheresToDebriefFormat,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding:  EdgeInsets.all(10.0),
                          //const EdgeInsets.symmetric(vertical: 75.0),
                        ),
                        onSaved: (String value) {},
                        validator:
                        RequiredValidator(errorText: "Adheres to debrief format is required"),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                              visualDensity:
                              VisualDensity(horizontal: -4, vertical: -4),
                              title: const Text('20 pt'),
                              leading: Radio(
                                value: 20,
                                activeColor: Colors.black87,
                                groupValue: groupValueA,
                                onChanged: (int a) => buttonChangeA(a),
                              )),
                          ListTile(
                              visualDensity:
                              VisualDensity(horizontal: -4, vertical: -4),
                              title: const Text('15 pt'),
                              leading: Radio(
                                value: 15,
                                activeColor: Colors.black87,
                                groupValue: groupValueA,
                                onChanged: (int a) => buttonChangeA(a),
                              )),
                          ListTile(
                              visualDensity:
                              VisualDensity(horizontal: -4, vertical: -4),
                              title: const Text('10 pt'),
                              leading: Radio(
                                value: 10,
                                activeColor: Colors.black87,
                                groupValue: groupValueA,
                                onChanged: (int a) => buttonChangeA(a),
                              )),
                          ListTile(
                              visualDensity:
                              VisualDensity(horizontal: -4, vertical: -4),
                              title: const Text('5 pt'),
                              leading: Radio(
                                value: 5,
                                activeColor: Colors.black87,
                                groupValue: groupValueA,
                                onChanged: (int a) => buttonChangeA(a),
                              )),
                          ListTile(
                            visualDensity:
                            VisualDensity(horizontal: -4, vertical: -4),
                            title: const Text('0 pt'),
                            leading: Radio(
                              value: 0,
                              activeColor: Colors.black87,
                              groupValue: groupValueA,
                              onChanged: (int a) => buttonChangeA(a),
                            ),
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
                     // mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 200.0,
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.top,
                            maxLength: 160,
                            maxLengthEnforced: true,
                            maxLines: 10,
                            controller: receptiveToFeedback,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding:   EdgeInsets.all(10.0),
                              //const EdgeInsets.symmetric(vertical: 75.0),
                            ),
                            onSaved: (String value) {},
                            validator:
                            RequiredValidator(errorText: "Receptive to feedback is required"),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                  visualDensity: VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  title: const Text('20 pt'),
                                  leading: Radio(
                                    value: 20,
                                    activeColor: Colors.black87,
                                    groupValue: groupValueB,
                                    onChanged: (int b) => buttonChangeB(b),
                                  )),
                              ListTile(
                                  visualDensity: VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  title: const Text('15 pt'),
                                  leading: Radio(
                                    value: 15,
                                    activeColor: Colors.black87,
                                    groupValue: groupValueB,
                                    onChanged: (int b) => buttonChangeB(b),
                                  )),
                              ListTile(
                                  visualDensity: VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  title: const Text('10 pt'),
                                  leading: Radio(
                                    value: 10,
                                    activeColor: Colors.black87,
                                    groupValue: groupValueB,
                                    onChanged: (int b) => buttonChangeB(b),
                                  )),
                              ListTile(
                                  visualDensity: VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  title: const Text('5 pt'),
                                  leading: Radio(
                                    value: 5,
                                    activeColor: Colors.black87,
                                    groupValue: groupValueB,
                                    onChanged: (int b) => buttonChangeB(b),
                                  )),
                              ListTile(
                                visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4),
                                title: const Text('0 pt'),
                                leading: Radio(
                                  value: 0,
                                  activeColor: Colors.black87,
                                  groupValue: groupValueB,
                                  onChanged: (int b) => buttonChangeB(b),
                                ),
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
                         // mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 200.0,
                              child: TextFormField(
                                textAlignVertical: TextAlignVertical.top,
                                maxLength: 160,
                                maxLengthEnforced: true,
                                maxLines: 10,
                                controller: improvementOriented,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding:   EdgeInsets.all(10.0),
                                  //const EdgeInsets.symmetric(vertical: 75.0),
                                ),
                                onSaved: (String value) {},
                                validator:
                                RequiredValidator(errorText: "Improvement oriented is required"),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                      visualDensity: VisualDensity(
                                          horizontal: -4, vertical: -4),
                                      title: const Text('20 pt'),
                                      leading: Radio(
                                        value: 20,
                                        activeColor: Colors.black87,
                                        groupValue: groupValueC,
                                        onChanged: (int c) => buttonChangeC(c),
                                      )),
                                  ListTile(
                                      visualDensity: VisualDensity(
                                          horizontal: -4, vertical: -4),
                                      title: const Text('15 pt'),
                                      leading: Radio(
                                        value: 15,
                                        activeColor: Colors.black87,
                                        groupValue: groupValueC,
                                        onChanged: (int c) => buttonChangeC(c),
                                      )),
                                  ListTile(
                                      visualDensity: VisualDensity(
                                          horizontal: -4, vertical: -4),
                                      title: const Text('10 pt'),
                                      leading: Radio(
                                        value: 10,
                                        activeColor: Colors.black87,
                                        groupValue: groupValueC,
                                        onChanged: (int c) => buttonChangeC(c),
                                      )),
                                  ListTile(
                                      visualDensity: VisualDensity(
                                          horizontal: -4, vertical: -4),
                                      title: const Text('5 pt'),
                                      leading: Radio(
                                        value: 5,
                                        activeColor: Colors.black87,
                                        groupValue: groupValueC,
                                        onChanged: (int c) => buttonChangeC(c),
                                      )),
                                  ListTile(
                                    visualDensity: VisualDensity(
                                        horizontal: -4, vertical: -4),
                                    title: const Text('0 pt'),
                                    leading: Radio(
                                      value: 0,
                                      activeColor: Colors.black87,
                                      groupValue: groupValueC,
                                      onChanged: (int c) => buttonChangeC(c),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
                ],
              ),
            ],
          ),
          ),
        ),
      bottomNavigationBar: Padding(
          padding:
          EdgeInsets.only(bottom: 40.0, left: 10.0, top: 40.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ElevatedButton(
                child: Text('Prev'),
                onPressed: () async {
                  navigation.currentState
                      .pushNamed('/leadership');
                },
              ),

              ElevatedButton(
                child: Text('Save'),
                onPressed: () async {
                  SharedPreferences prefs =
                  await SharedPreferences.getInstance();
                  prefs.setString('adheresToDebriefFormat', adheresToDebriefFormat.text);
                  prefs.setString(
                        'receptiveToFeedback', receptiveToFeedback.text);
                  prefs.setString('improvementOriented', improvementOriented.text);

                  prefs.setInt('groupValueA', groupValueA);
                  prefs.setInt('groupValueB', groupValueB);
                  prefs.setInt('groupValueC', groupValueC);
                },
              ),
              ElevatedButton(
                child: Text('Confirm'),
                onPressed: () async {

                  navigation.currentState
                      .pushNamed('/confirmation');
                },
              ),
            ],
          )
      ),
    );
  }
}
