import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';

/*
 Author: Kyle Serruys
  This class is the Execution page of our peer review
 */

class Execution extends StatelessWidget {
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

          //Time Management
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text('Time Management'),
                ),
                Container(
                  child:  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 200.0,
                        child: TextFormField(
                          maxLines: 5,
                          controller: timeManagement,
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

                //Resources Management
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text('Resources Management'),
                    ),
                    Container(
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            width: 200.0,
                            child: TextFormField(
                              maxLines: 5,
                              controller: resourcesManagement,
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

                    //Flexibility
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                          child: Text('Flexibility'),
                        ),
                        Container(
                          child:  Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                width: 200.0,
                                child: TextFormField(
                                  maxLines: 5,
                                  controller: flexibility,
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

                        //Mission Success
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                              child: Text('Mission Success'),
                            ),
                            Container(
                              child:  Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    width: 200.0,
                                    child: TextFormField(
                                      maxLines: 5,
                                      controller: missionSuccess,
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
