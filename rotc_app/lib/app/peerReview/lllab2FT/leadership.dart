import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../home.dart';
import '../peerReviewLanding.dart';
/*
 Author: Kyle Serruys
  This class is the Leadership page of our peer review
 */

class Leadership extends StatefulWidget {
  Leadership() : super();

  @override
  LeadershipState createState() => LeadershipState();
}

class LeadershipState extends State<Leadership> {
  TextEditingController commandPresence;
  TextEditingController delegation;
  TextEditingController empowerment;
  TextEditingController maintainsControl;

  int groupValueA;
  int groupValueB;
  int groupValueC;
  int groupValueD;

  @override
  void initState() {
    super.initState();
    initControllers();
    initRadioButtons();
  }

  initControllers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var commandPresenceValue =
      prefs.getString("commandPresence");
      commandPresence =
          TextEditingController(text: commandPresenceValue);

      var delegationValue = prefs.getString("delegation");
      delegation =
          TextEditingController(text: delegationValue);

      var empowermentValue = prefs.getString("empowerment");
      empowerment =
          TextEditingController(text: empowermentValue);

      var maintainsControlValue = prefs.getString("maintainsControl");
      maintainsControl =
          TextEditingController(text: maintainsControlValue);
    });
  }

  initRadioButtons() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var lValueA = prefs.getString("leadershipValueA");
      var lValueB = prefs.getString("leadershipValueB");
      var lValueC = prefs.getString("leadershipValueC");
      var lValueD = prefs.getString("leadershipValueD");

      if (lValueA != null) {
        buttonChangeA(int.parse(lValueA));
      }
      if (lValueB != null) {
        buttonChangeB(int.parse(lValueB));
      }
      if (lValueC != null) {
        buttonChangeC(int.parse(lValueC));
      }
      if (lValueD != null) {
        buttonChangeD(int.parse(lValueD));
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

  void buttonChangeD(int button) {
    setState(() {
      if (button == 20) {
        groupValueD = 20;
      } else if (button == 15) {
        groupValueD = 15;
      } else if (button == 10) {
        groupValueD = 10;
      } else if (button == 5) {
        groupValueD = 5;
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
        ),
        title: Text('Leadership'),
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
          //Command Presence
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text('Command Presence'),
              ),
              Container(
                child: Row(
                  //mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 200.0,
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.top,
                        maxLength: 160,
                        maxLengthEnforced: true,
                        maxLines: 10,
                        controller: commandPresence,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(10.0),
                          // const EdgeInsets.symmetric(vertical: 75.0),
                        ),
                        onSaved: (String value) {},
                        validator:
                        RequiredValidator(errorText: "Command presence is required"),
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

              //Delegation
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text('Delegation'),
                  ),
                  Container(
                    child: Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 200.0,
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.top,
                            maxLength: 160,
                            maxLengthEnforced: true,
                            maxLines: 10,
                            controller: delegation,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding: EdgeInsets.all(10.0),
                              //const EdgeInsets.symmetric(vertical: 75.0),
                            ),
                            onSaved: (String value) {},
                            validator:
                            RequiredValidator(errorText: "Delegation is required"),
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

                  //Empowerment
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text('Empowerment'),
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
                                controller: empowerment,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: EdgeInsets.all(10.0),
                                  //const EdgeInsets.symmetric(vertical: 75.0),
                                ),
                                onSaved: (String value) {},
                                validator:
                                RequiredValidator(errorText: "Empowerment is required"),
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

                      //Maintains Control
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Text('Maintains Control'),
                          ),
                          Container(
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 200.0,
                                  child: TextFormField(
                                    textAlignVertical: TextAlignVertical.top,
                                    maxLength: 160,
                                    maxLengthEnforced: true,
                                    maxLines: 10,
                                    controller: maintainsControl,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      contentPadding: EdgeInsets.all(10.0),
                                      //const EdgeInsets.symmetric(vertical: 75.0),
                                    ),
                                    onSaved: (String value) {},
                                    validator:
                                    RequiredValidator(errorText: "Maintains control is required"),
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
                                            groupValue: groupValueD,
                                            onChanged: (int d) =>
                                                buttonChangeD(d),
                                          )),
                                      ListTile(
                                          visualDensity: VisualDensity(
                                              horizontal: -4, vertical: -4),
                                          title: const Text('15 pt'),
                                          leading: Radio(
                                            value: 15,
                                            activeColor: Colors.black87,
                                            groupValue: groupValueD,
                                            onChanged: (int d) =>
                                                buttonChangeD(d),
                                          )),
                                      ListTile(
                                          visualDensity: VisualDensity(
                                              horizontal: -4, vertical: -4),
                                          title: const Text('10 pt'),
                                          leading: Radio(
                                            value: 10,
                                            activeColor: Colors.black87,
                                            groupValue: groupValueD,
                                            onChanged: (int d) =>
                                                buttonChangeD(d),
                                          )),
                                      ListTile(
                                          visualDensity: VisualDensity(
                                              horizontal: -4, vertical: -4),
                                          title: const Text('5 pt'),
                                          leading: Radio(
                                            value: 5,
                                            activeColor: Colors.black87,
                                            groupValue: groupValueD,
                                            onChanged: (int d) =>
                                                buttonChangeD(d),
                                          )),
                                      ListTile(
                                        visualDensity: VisualDensity(
                                            horizontal: -4, vertical: -4),
                                        title: const Text('0 pt'),
                                        leading: Radio(
                                          value: 0,
                                          activeColor: Colors.black87,
                                          groupValue: groupValueD,
                                          onChanged: (int d) =>
                                              buttonChangeD(d),
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
                  navigation.currentState.pushNamed('/execution');
                },
              ),
              ElevatedButton(
                child: Text('Save'),
                onPressed: () async {
                  SharedPreferences prefs = await SharedPreferences.getInstance();
                  prefs.setString('commandPresence', commandPresence.text);
                  prefs.setString('delegation', delegation.text);
                  prefs.setString('empowerment', empowerment.text);
                  prefs.setString('maintainsControl', maintainsControl.text);
                  prefs.setString('leadershipValueA', groupValueA.toString());
                  prefs.setString('leadershipValueB', groupValueB.toString());
                  prefs.setString('leadershipValueC', groupValueC.toString());
                  prefs.setString('leadershipValueD', groupValueD.toString());
                  saveNotification(context);
                },
              ),
              ElevatedButton(
                child: Text('Next'),
                onPressed: () async {
                  navigation.currentState.pushNamed('/debrief');
                },
              ),
            ],
          )),
    );
  }
}

saveNotification(BuildContext context) {
  Widget button = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    //  title: Text("Saved"),
    content: Text("Input is saved"),
    actions: [
      button,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}