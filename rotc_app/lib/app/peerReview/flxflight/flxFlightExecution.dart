import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

/*
 Author: Sawyer Kisha
  This class is the Execution page of our flxflight peer review
 */

class flxFlightExecution extends StatelessWidget {
  TextEditingController timeManagement = TextEditingController();
  TextEditingController resourcesManagement = TextEditingController();
  TextEditingController flexibility = TextEditingController();
  TextEditingController missionSuccess = TextEditingController();

  CollectionReference execution = FirebaseFirestore.instance.collection('execution');

  Future<void> peerReviewExecution() {
    return execution.add({
      'timeManagement': timeManagement.text,
      'resourcesManagement': resourcesManagement.text,
      'flexibility': flexibility.text,
      'missionSuccess': missionSuccess.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Execution'),
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