import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
  TextEditingController commandPresence = TextEditingController();
  TextEditingController delegation = TextEditingController();
  TextEditingController empowerment = TextEditingController();
  TextEditingController maintainsControl = TextEditingController();

  CollectionReference leadership =
      FirebaseFirestore.instance.collection('leadership');
  CollectionReference leadershipScores =
      FirebaseFirestore.instance.collection('leadershipScores');

  Future<void> peerReviewLeadership() {
    return leadership.add({
      'commandPresence': commandPresence.text,
      'delegation': delegation.text,
      'empowerment': empowerment.text,
      'maintainsControl': maintainsControl.text,
    });
  }

  Future<void> peerReviewLeadershipScores() {
    return leadershipScores.add({
      'commandPresenceScore': groupValueA,
      'delegationScore': groupValueB,
      'empowermentScore': groupValueC,
      'maintainsControlScore': groupValueD,
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 200.0,
                      child: TextFormField(
                        maxLines: 5,
                        controller: commandPresence,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding:
                              const EdgeInsets.symmetric(vertical: 75.0),
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
                              leading: Radio(
                                value: 20,
                                activeColor: Colors.black87,
                                groupValue: groupValueA,
                                onChanged: (int a) => buttonChangeA(a),
                              )),
                          ListTile(
                              title: const Text('15 pt'),
                              leading: Radio(
                                  value: 15,
                                  activeColor: Colors.black87,
                                  groupValue: null,
                                  onChanged: null)),
                          ListTile(
                              title: const Text('10 pt'),
                              leading: Radio(
                                value: 10,
                                activeColor: Colors.black87,
                                groupValue: groupValueA,
                                onChanged: (int a) => buttonChangeA(a),
                              )),
                          ListTile(
                              title: const Text('5 pt'),
                              leading: Radio(
                                  value: 5,
                                  activeColor: Colors.black87,
                                  groupValue: null,
                                  onChanged: null)),
                          ListTile(
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 200.0,
                          child: TextFormField(
                            maxLines: 5,
                            controller: delegation,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 75.0),
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
                                  leading: Radio(
                                    value: 20,
                                    activeColor: Colors.black87,
                                    groupValue: groupValueB,
                                    onChanged: (int b) => buttonChangeB(b),
                                  )),
                              ListTile(
                                  title: const Text('15 pt'),
                                  leading: Radio(
                                      value: 15,
                                      activeColor: Colors.black87,
                                      groupValue: null,
                                      onChanged: null)),
                              ListTile(
                                  title: const Text('10 pt'),
                                  leading: Radio(
                                    value: 10,
                                    activeColor: Colors.black87,
                                    groupValue: groupValueB,
                                    onChanged: (int b) => buttonChangeB(b),
                                  )),
                              ListTile(
                                  title: const Text('5 pt'),
                                  leading: Radio(
                                      value: 5,
                                      activeColor: Colors.black87,
                                      groupValue: null,
                                      onChanged: null)),
                              ListTile(
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
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 200.0,
                              child: TextFormField(
                                maxLines: 5,
                                controller: empowerment,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 75.0),
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
                                      leading: Radio(
                                        value: 20,
                                        activeColor: Colors.black87,
                                        groupValue: groupValueC,
                                        onChanged: (int c) => buttonChangeC(c),
                                      )),
                                  ListTile(
                                      title: const Text('15 pt'),
                                      leading: Radio(
                                          value: 15,
                                          activeColor: Colors.black87,
                                          groupValue: null,
                                          onChanged: null)),
                                  ListTile(
                                      title: const Text('10 pt'),
                                      leading: Radio(
                                        value: 10,
                                        activeColor: Colors.black87,
                                        groupValue: groupValueC,
                                        onChanged: (int c) => buttonChangeC(c),
                                      )),
                                  ListTile(
                                      title: const Text('5 pt'),
                                      leading: Radio(
                                          value: 5,
                                          activeColor: Colors.black87,
                                          groupValue: null,
                                          onChanged: null)),
                                  ListTile(
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
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 200.0,
                                  child: TextFormField(
                                    maxLines: 5,
                                    controller: maintainsControl,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      contentPadding:
                                          const EdgeInsets.symmetric(
                                              vertical: 75.0),
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
                                          leading: Radio(
                                            value: 20,
                                            activeColor: Colors.black87,
                                            groupValue: groupValueD,
                                            onChanged: (int d) =>
                                                buttonChangeD(d),
                                          )),
                                      ListTile(
                                          title: const Text('15 pt'),
                                          leading: Radio(
                                              value: 15,
                                              activeColor: Colors.black87,
                                              groupValue: null,
                                              onChanged: null)),
                                      ListTile(
                                          title: const Text('10 pt'),
                                          leading: Radio(
                                            value: 10,
                                            activeColor: Colors.black87,
                                            groupValue: groupValueD,
                                            onChanged: (int d) =>
                                                buttonChangeD(d),
                                          )),
                                      ListTile(
                                          title: const Text('5 pt'),
                                          leading: Radio(
                                              value: 5,
                                              activeColor: Colors.black87,
                                              groupValue: null,
                                              onChanged: null)),
                                      ListTile(
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              ElevatedButton(
                                child: Text('Prev'),
                                onPressed: () async {
                                  navigation.currentState
                                      .pushNamed('/execution');
                                },
                              ),
                              ElevatedButton(
                                child: Text('Save'),
                                onPressed: () async {
                                  await peerReviewLeadershipScores();
                                  await peerReviewLeadership();
                                },
                              ),
                              ElevatedButton(
                                child: Text('Next'),
                                onPressed: () async {
                                  navigation.currentState.pushNamed('/debrief');
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
