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

          //Use of Chain of Command
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text('Use of Chain of Command'),
              ),
              Container(
                child:  Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 200.0,
                      child: TextFormField(
                        maxLines: 5,
                        controller: chainOfCommand,
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

              //Maintains Team's Situational Awareness
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text("Maintains Team's Situational Awareness"),
                  ),
                  Container(
                    child:  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 200.0,
                          child: TextFormField(
                            maxLines: 5,
                            controller: situationalAwareness,
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
