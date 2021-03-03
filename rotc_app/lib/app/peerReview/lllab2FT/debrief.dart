import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';

/*
 Author: Kyle Serruys
  This class is the Debrief page of our peer review
 */
class Debrief extends StatefulWidget {
  Debrief() : super();

  @override
  DebriefState createState() => DebriefState();
}

class DebriefState extends State<Debrief> {
  TextEditingController debrief;

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
      var debriefValue = prefs.getString("debrief");
      debrief = TextEditingController(text: debriefValue);
    });
  }

  initRadioButtons() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var dValue = prefs.getString("debriefValue");

      if (dValue != null) {
        buttonChange(int.parse(dValue));
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
        title: Text('Debrief'),
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
          //Adheres To Debrief Format
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
                  controller: debrief,
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
                        navigation.currentState.pushNamed('/leadership');
                      },
                    ),
                    ElevatedButton(
                      child: Text('Save'),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('debrief', debrief.text);
                        prefs.setString('debriefValue', groupValue.toString());
                        saveNotification(context);
                      },
                    ),
                    ElevatedButton(
                      child: Text('Confirm'),
                      onPressed: () async {
                        navigation.currentState.pushNamed('/confirmation');
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
