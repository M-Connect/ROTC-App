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

          //Adheres To Debrief Format
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text('Adheres to Debrief Format'),
              ),
              Container(
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 200.0,
                      child: TextFormField(
                        maxLines: 5,
                        controller: adheresToDebriefFormat,
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
                              leading: Radio(value: 20, groupValue: null, onChanged: null)
                          ),
                          ListTile(
                              title: const Text('15 pt'),
                              leading: Radio(value: 15, groupValue: null, onChanged: null)
                          ),
                          ListTile(
                              title: const Text('10 pt'),
                              leading: Radio(value: 10, groupValue: null, onChanged: null)
                          ),
                          ListTile(
                              title: const Text('5 pt'),
                              leading: Radio(value: 5, groupValue: null, onChanged: null)
                          ),
                          ListTile(
                            title: const Text('0 pt'),
                            leading: Radio(value: 0, groupValue: null, onChanged: null),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //Receptive to Feedback
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text('Receptive to Feedback'),
                  ),
                  Container(
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 200.0,
                          child: TextFormField(
                            maxLines: 5,
                            controller: receptiveToFeedback,
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
                                  leading: Radio(value: 20, groupValue: null, onChanged: null)
                              ),
                              ListTile(
                                  title: const Text('15 pt'),
                                  leading: Radio(value: 15, groupValue: null, onChanged: null)
                              ),
                              ListTile(
                                  title: const Text('10 pt'),
                                  leading: Radio(value: 10, groupValue: null, onChanged: null)
                              ),
                              ListTile(
                                  title: const Text('5 pt'),
                                  leading: Radio(value: 5, groupValue: null, onChanged: null)
                              ),
                              ListTile(
                                title: const Text('0 pt'),
                                leading: Radio(value: 0, groupValue: null, onChanged: null),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Improvement-Oriented
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text('Improvement-Oriented'),
                      ),
                      Container(
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 200.0,
                              child: TextFormField(
                                maxLines: 5,
                                controller: improvementOriented,
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
                                      leading: Radio(value: 20, groupValue: null, onChanged: null)
                                  ),
                                  ListTile(
                                      title: const Text('15 pt'),
                                      leading: Radio(value: 15, groupValue: null, onChanged: null)
                                  ),
                                  ListTile(
                                      title: const Text('10 pt'),
                                      leading: Radio(value: 10, groupValue: null, onChanged: null)
                                  ),
                                  ListTile(
                                      title: const Text('5 pt'),
                                      leading: Radio(value: 5, groupValue: null, onChanged: null)
                                  ),
                                  ListTile(
                                    title: const Text('0 pt'),
                                    leading: Radio(value: 0, groupValue: null, onChanged: null),
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
