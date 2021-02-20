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
      'teamOrganization': timeManagement.text,
      'resourcesManagement': resourcesManagement.text,
      'flexibility': flexibility.text,
      'missionSuccess': missionSuccess.text,
    });
  }

  Future<void> peerReviewExecutionScores() {
    return executionScores.add({
      'teamOrganizationScore': groupValueA,
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
      appBar: AppBar(title: Text('Execution'),
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
                child: Text('Team Organization'),
              ),
              TextFormField(
                maxLines: 3,
                controller: timeManagement,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onSaved: (String value) {},
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Radio(value: 20, groupValue: null, onChanged: null),
                  Text('(O) 20 pt'),
                  Radio(value: 10, groupValue: null, onChanged: null),
                  Text('(S) 10 pt'),
                  Radio(value: 0, groupValue: null, onChanged: null),
                  Text('(U) 0 pt'),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text('Resources Management'),
                  ),
                  TextFormField(
                    maxLines: 3,
                    controller: resourcesManagement,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    onSaved: (String value) {},
                  ),
                  ButtonBar(
                    alignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Radio(value: 20, groupValue: null, onChanged: null),
                      Text('(O) 20 pt'),
                      Radio(value: 10, groupValue: null, onChanged: null),
                      Text('(S) 10 pt'),
                      Radio(value: 0, groupValue: null, onChanged: null),
                      Text('(U) 0 pt'),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text('Flexibility'),
                      ),
                      TextFormField(
                        maxLines: 3,
                        controller: flexibility,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                        ),
                        onSaved: (String value) {},
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Radio(value: 20, groupValue: null, onChanged: null),
                          Text('(O) 20 pt'),
                          Radio(value: 10, groupValue: null, onChanged: null),
                          Text('(S) 10 pt'),
                          Radio(value: 0, groupValue: null, onChanged: null),
                          Text('(U) 0 pt'),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Text('Mission Success'),
                          ),
                          TextFormField(
                            maxLines: 3,
                            controller: missionSuccess,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                            ),
                            onSaved: (String value) {},
                          ),
                          ButtonBar(
                            alignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Radio(
                                  value: 20, groupValue: null, onChanged: null),
                              Text('(O) 20 pt'),
                              Radio(
                                  value: 10, groupValue: null, onChanged: null),
                              Text('(S) 10 pt'),
                              Radio(
                                  value: 0, groupValue: null, onChanged: null),
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
                                    await peerReviewExecutionScores();
                                    await peerReviewExecution();
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
