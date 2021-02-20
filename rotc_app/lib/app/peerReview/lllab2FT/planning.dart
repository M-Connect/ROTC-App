import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../peerReviewLanding.dart';
/*
 Author: Kyle Serruys
  This class is the Planning page of our peer review
 */

class Planning extends StatelessWidget {
  TextEditingController teamOrganization = TextEditingController();
  TextEditingController outsidePreparation = TextEditingController();
  TextEditingController missionFocus = TextEditingController();
  TextEditingController creativity = TextEditingController();

  CollectionReference planning = FirebaseFirestore.instance.collection('planning');

  Future<void> peerReviewPlanning() {
    return planning.add({
      'teamOrganization': teamOrganization.text,
      'outsidePreparation': outsidePreparation.text,
      'missionFocus': missionFocus.text,
      'creativity': creativity.text,
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
                controller: teamOrganization,
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
                    child: Text('Outside Preparation'),
                  ),
                  TextFormField(
                    maxLines: 3,
                    controller: outsidePreparation,
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
                        child: Text('Mission Focus'),
                      ),
                      TextFormField(
                        maxLines: 3,
                        controller: missionFocus,
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
                            child: Text('Creativity'),
                          ),
                          TextFormField(
                            maxLines: 3,
                            controller: creativity,
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
