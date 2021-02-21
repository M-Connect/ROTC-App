import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

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
            onPressed: () {

            },
          ),
        ],),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Form(

          //Command Presence
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text('Command Presence'),
              ),
              Container(
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 200.0,
                      child: TextFormField(
                        maxLines: 5,
                        controller: commandPresence,
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

              //Delegation
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text('Delegation'),
                  ),
                  Container(
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 200.0,
                          child: TextFormField(
                            maxLines: 5,
                            controller: delegation,
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

                  //Empowerment
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text('Empowerment'),
                      ),
                      Container(
                        child:  Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 200.0,
                              child: TextFormField(
                                maxLines: 5,
                                controller: empowerment,
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

                      //Maintains Control
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Text('Maintains Control'),
                          ),
                          Container(
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 200.0,
                                  child: TextFormField(
                                    maxLines: 5,
                                    controller: maintainsControl,
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
