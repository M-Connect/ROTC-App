import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../home.dart';
import '../peerReviewLanding.dart';
/*
 Author: Kyle Serruys
  This class is the Leadership page of our peer review
 */

class Leadership extends StatelessWidget {
  TextEditingController commandPresence = TextEditingController();
  TextEditingController delegation = TextEditingController();
  TextEditingController empowerment = TextEditingController();
  TextEditingController maintainsControl = TextEditingController();

  CollectionReference leadership = FirebaseFirestore.instance.collection('leadership');

  Future<void> peerReviewLeadership() {
    return leadership.add({
      'commandPresence': commandPresence.text,
      'delegation': delegation.text,
      'empowerment': empowerment.text,
      'maintainsControl': maintainsControl.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Leadership'),
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
                child: Text('Confidence/Command Presence'),
              ),
              TextFormField(
                maxLines: 3,
                controller: commandPresence,
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
                    child: Text('Delegation'),
                  ),
                  TextFormField(
                    maxLines: 3,
                    controller: delegation,
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
                        child: Text('Empowerment'),
                      ),
                      TextFormField(
                        maxLines: 3,
                        controller: empowerment,
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
                            child: Text('Maintains Control Over Situation'),
                          ),
                          TextFormField(
                            maxLines: 3,
                            controller: maintainsControl,
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

                                    await peerReviewLeadership();
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
