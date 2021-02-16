import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';


/*
 Author: Kyle Serruys
  This class is the Debrief page of our peer review
 */
class Debrief extends StatelessWidget {
  TextEditingController adheresToDebriefFormat = TextEditingController();
  TextEditingController receptiveToFeedback = TextEditingController();
  TextEditingController improvementOriented = TextEditingController();

  CollectionReference debrief = FirebaseFirestore.instance.collection('debrief');

  Future<void> peerReviewDebrief() {
    return debrief.add({
      'adheresToDebriefFormat': adheresToDebriefFormat.text,
      'receptiveToFeedback': receptiveToFeedback.text,
      'improvementOriented': improvementOriented.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Debrief'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
            onPressed: () {

            },
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
