import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';
import '../peerReviewLanding.dart';
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
  TextEditingController chainOfCommand = TextEditingController();
  TextEditingController situationalAwareness = TextEditingController();

  CollectionReference communicationScores = FirebaseFirestore.instance
      .collection('communicationScores');
  CollectionReference communication =
      FirebaseFirestore.instance.collection('communication');

  Future<void> peerReviewCommunications() {
    return communication.add({
      'chainOfCommand': chainOfCommand.text,
      'situationalAwareness': situationalAwareness.text,
    });
  }

  peerReviewCommunicationScores() {
    return communicationScores.add({
      'useOfChainOfCommandScore': groupValueA,
      'teamSituationalAwarenessScore': groupValueB,
    });
  }

  int groupValueA;
  int groupValueB;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 200.0,
                      child: TextFormField(
                        maxLines: 5,
                        controller: chainOfCommand,
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

              //Maintains Team's Situational Awareness
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text("Maintains Team's Situational Awareness"),
                  ),
                  Container(
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 200.0,
                          child: TextFormField(
                            maxLines: 5,
                            controller: situationalAwareness,
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
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        child: ElevatedButton(
                          child: Text('Submit'),
                          onPressed: () async {
                            await peerReviewCommunicationScores();
                            await peerReviewCommunications();
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
        ),
      ),
    );
  }
}
