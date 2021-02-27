import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';
/*
 Author: Kyle Serruys
  This class is the Communication page of our peer review
 */

class Communication extends StatefulWidget {
  Communication() : super();

  @override
  CommunicationState createState() => CommunicationState();
}

class CommunicationState extends State<Communication> {
  TextEditingController chainOfCommand;
  TextEditingController situationalAwareness;

  int groupValueA;
  int groupValueB;

  @override
  void initState() {
    super.initState();
    initControllers();
    initRadioButtons();
  }

  initControllers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var chainOfCommandValue =
      prefs.getString("chainOfCommand");
      chainOfCommand =
          TextEditingController(text: chainOfCommandValue);

      var situationalAwarenessValue = prefs.getString("situationalAwareness");
      situationalAwareness =
          TextEditingController(text: situationalAwarenessValue);

    });
  }

  initRadioButtons() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var cValueA = prefs.getString("communicationValueA");
      var cValueB = prefs.getString("communicationValueB");

      if (cValueA != null) {
        buttonChangeA(int.parse(cValueA));
      }
      if (cValueB != null) {
        buttonChangeB(int.parse(cValueB));
      }
    });
  }


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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            navigation.currentState.pushNamed('/peerReviewLLAB2FT');
          },
        ),
        title: Text('Communication'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Form(
          //Use of Chain of Command
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text('Use of Chain of Command'),
              ),
              Container(
                child: Row(
                  //  mainAxisAlignment: MainAxisAlignment.start,

                  children: <Widget>[
                    Container(
                      width: 200.0,
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.top,
                        maxLength: 160,
                        maxLengthEnforced: true,
                        maxLines: 10,
                        controller: chainOfCommand,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding:
                              // const EdgeInsets.symmetric(vertical: 75.0),

                              EdgeInsets.all(10.0),
                        ),
                        onSaved: (String value) {},
                        validator:
                          RequiredValidator(errorText: "Chain of Command is required"),

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
                            ),
                          ),
                          ListTile(
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4),
                            title: const Text('15 pt'),
                            leading: Radio(
                              value: 15,
                              activeColor: Colors.black87,
                              groupValue: groupValueA,
                              onChanged: (int a) => buttonChangeA(a),
                            ),
                          ),
                          ListTile(
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4),
                            title: const Text('10 pt'),
                            leading: Radio(
                              value: 10,
                              activeColor: Colors.black87,
                              groupValue: groupValueA,
                              onChanged: (int a) => buttonChangeA(a),
                            ),
                          ),
                          ListTile(
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4),
                            title: const Text('5 pt'),
                            leading: Radio(
                              value: 5,
                              activeColor: Colors.black87,
                              groupValue: groupValueA,
                              onChanged: (int a) => buttonChangeA(a),
                            ),
                          ),
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

              //Maintains Team's Situational Awareness
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
                    child: Text("Maintains Team's Situational Awareness"),
                  ),
                  Container(
                    child: Row(
                      //  mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 200.0,
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.top,
                            maxLength: 160,
                            maxLengthEnforced: true,
                            maxLines: 10,
                            controller: situationalAwareness,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding:
                                  //   const EdgeInsets.symmetric(vertical: 75.0),

                                  EdgeInsets.all(10.0),
                            ),
                            onSaved: (String value) {},
                            validator:

                            RequiredValidator(errorText: "Maintains team's situational awareness is required."),
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
                                  groupValue: groupValueB,
                                  onChanged: (int b) => buttonChangeB(b),
                                ),
                              ),
                              ListTile(
                                visualDensity:
                                    VisualDensity(horizontal: -4, vertical: -4),
                                title: const Text('15 pt'),
                                leading: Radio(
                                  value: 15,
                                  activeColor: Colors.black87,
                                  groupValue: groupValueB,
                                  onChanged: (int b) => buttonChangeB(b),
                                ),
                              ),
                              ListTile(
                                visualDensity:
                                    VisualDensity(horizontal: -4, vertical: -4),
                                title: const Text('10 pt'),
                                leading: Radio(
                                  value: 10,
                                  activeColor: Colors.black87,
                                  groupValue: groupValueB,
                                  onChanged: (int b) => buttonChangeB(b),
                                ),
                              ),
                              ListTile(
                                visualDensity:
                                    VisualDensity(horizontal: -4, vertical: -4),
                                title: const Text('5 pt'),
                                leading: Radio(
                                  value: 5,
                                  activeColor: Colors.black87,
                                  groupValue: groupValueB,
                                  onChanged: (int b) => buttonChangeB(b),
                                ),
                              ),
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
                  navigation.currentState.pushNamed('/planning');
                },
              ),
              ElevatedButton(
                child: Text('Save'),
                onPressed: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.setString('chainOfCommand', chainOfCommand.text);
                  prefs.setString(
                      'situationalAwareness', situationalAwareness.text);
                  prefs.setString('communicationValueA', groupValueA.toString());
                  prefs.setString('communicationValueB', groupValueB.toString());
                },
              ),
              ElevatedButton(
                child: Text('Next'),
                onPressed: () async {
                  navigation.currentState.pushNamed('/execution');
                },
              ),
            ],
          )),
    );
  }
}
