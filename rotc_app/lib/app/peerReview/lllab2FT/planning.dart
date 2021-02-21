import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

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
      onPressed: () {

      },
    ),
    ],
      ),

    body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Center(

          //Team Organization
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
          Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: Text('Team Organization'),
        ),
          Container(
          child:  Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                width: 200.0,
                child: TextFormField(
                  maxLines: 5,
                  controller: teamOrganization,
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

              //Outside Preparation
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text('Outside Preparation'),
                  ),
                  Container(
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 200.0,
                          child: TextFormField(
                            maxLines: 5,
                            controller: outsidePreparation,
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

                  //Mission Focus
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text('Mission Focus'),
                      ),
                      Container(
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 200.0,
                              child: TextFormField(
                                maxLines: 5,
                                controller: missionFocus,
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

                      //Creativity
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Text('Creativity'),
                          ),
                          Container(
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 200.0,
                                  child: TextFormField(
                                    maxLines: 5,
                                    controller: creativity,
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
