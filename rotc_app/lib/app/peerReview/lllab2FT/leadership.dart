import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../home.dart';
import '../peerReviewLanding.dart';
/*
 Author: Kyle Serruys
  This class is the Leadership page of our peer review
 */

class Leadership extends StatefulWidget {
  Leadership() : super();

  @override
  LeadershipState createState() => LeadershipState();
}

class LeadershipState extends State<Leadership> {
  TextEditingController leadership;

  int groupValue;

  @override
  void initState() {
    super.initState();
    initControllers();
    initRadioButtons();
  }

  initControllers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var leadershipValue = prefs.getString("leadership");
      leadership = TextEditingController(text: leadershipValue);
    });
  }

  initRadioButtons() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var lValue = prefs.getString("leadershipValue");

      if (lValue != null) {
        buttonChange(int.parse(lValue));
      }
    });
  }

  void buttonChange(int button) {
    setState(() {
      if (button == 20) {
        groupValue = 20;
      } else if (button == 15) {
        groupValue = 15;
      } else if (button == 10) {
        groupValue = 10;
      } else if (button == 5) {
        groupValue = 5;
      } else if (button == 0) {
        groupValue = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        title: Text('Leadership'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Center(
          //Command Presence
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 50.0,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Radio(
                      value: 0,
                      activeColor: Colors.black87,
                      groupValue: groupValue,
                      onChanged: (int button) => buttonChange(button),
                    ),
                    Text('0'),
                    Radio(
                      value: 5,
                      activeColor: Colors.black87,
                      groupValue: groupValue,
                      onChanged: (int button) => buttonChange(button),
                    ),
                    Text('5'),
                    Radio(
                      value: 10,
                      activeColor: Colors.black87,
                      groupValue: groupValue,
                      onChanged: (int button) => buttonChange(button),
                    ),
                    Text('10'),
                    Radio(
                      value: 15,
                      activeColor: Colors.black87,
                      groupValue: groupValue,
                      onChanged: (int button) => buttonChange(button),
                    ),
                    Text('15'),
                    Radio(
                      value: 20,
                      activeColor: Colors.black87,
                      groupValue: groupValue,
                      onChanged: (int button) => buttonChange(button),
                    ),
                    Text('20'),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text('Evaluator Notes:'),
                    ),
                  ],
                ),
              ),
              Container(
                width: 200.0,
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.top,
                  maxLength: 160,
                  maxLengthEnforced: true,
                  maxLines: 10,
                  controller: leadership,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding:
                        // const EdgeInsets.symmetric(vertical: 75.0),

                        EdgeInsets.all(10.0),
                  ),
                  onSaved: (String value) {},
                  validator: RequiredValidator(
                      errorText: "Chain of Command is required"),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: Text('Prev'),
                      onPressed: () async {
                        navigation.currentState.pushNamed('/execution');
                      },
                    ),
                    ElevatedButton(
                      child: Text('Save'),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('leadership', leadership.text);
                        prefs.setString(
                            'leadershipValue', groupValue.toString());
                        saveNotification(context);
                      },
                    ),
                    ElevatedButton(
                      child: Text('Next'),
                      onPressed: () async {
                        navigation.currentState.pushNamed('/debrief');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

saveNotification(BuildContext context) {
  Widget button = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    //  title: Text("Saved"),
    content: Text("Input is saved"),
    actions: [
      button,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
