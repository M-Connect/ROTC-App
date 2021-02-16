import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../main.dart';

/*
 Author: Kyle Serruys
  This class is the Communication page of our peer review
 */
class Communication extends StatelessWidget {
  TextEditingController chainOfCommand = TextEditingController();
  TextEditingController situationalAwareness = TextEditingController();

  CollectionReference communication =
      FirebaseFirestore.instance.collection('communication');

  Future<void> peerReviewCommunications() {
    return communication.add({
      'chainOfCommand': chainOfCommand.text,
      'situationalAwareness': situationalAwareness.text,
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
                      Radio(value: 20, groupValue: null, onChanged: null),
                      Text('(O) 20 pt'),
                      Radio(value: 10, groupValue: null, onChanged: null),
                      Text('(S) 10 pt'),
                      Radio(value: 0, groupValue: null, onChanged: null),
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
