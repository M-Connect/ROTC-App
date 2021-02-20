import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text('Use of Chain of Command'),
              ),
              TextFormField(
                maxLines: 3,
                controller: chainOfCommand,
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
                    child: Text('Maintains Team Situational Awareness'),
                  ),
                  TextFormField(
                    maxLines: 3,
                    controller: situationalAwareness,
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