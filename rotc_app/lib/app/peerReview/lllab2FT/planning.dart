import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
/*
 Author: Kyle Serruys
  This class is the Planning page of our peer review
 */

class Planning extends StatefulWidget {
  Planning() : super();

  @override
  PlanningState createState() => PlanningState();
}

class PlanningState extends State<Planning> {
  TextEditingController planning;

  String firstName ="";
  String lastName ="";
  String emailAddress = "";
  String nickname ="";
  bool isCadre;
  double planningValue = 10;

  @override
  void initState() {
    super.initState();
    initControllers();
    getUserInfo();
  //  initSliderValue();
  }

  initControllers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var planningValue = prefs.getString("planning");
      planning = TextEditingController(text: planningValue);
    });
  }

  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
       firstName = prefs.getString("firstName");
       lastName = prefs.getString("lastName");
       emailAddress = prefs.getString("email");
       nickname = prefs.getString('nickname');
       isCadre = prefs.getString('isCadre') == 'true';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            navigation.currentState.pushNamed('/peerReviewLLAB2FT');
          },
        ),
        title: Text('Planning'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
            onPressed: () {
              alertSignOut(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(child: Text('$firstName $lastName $nickname $emailAddress $isCadre'),),
              SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: (Border.all(
                        color: Colors.black87,
                      )),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(planningValue.round().toString()),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                child: Slider(
                  value: planningValue,
                  onChanged: (newSliderValue) {
                    setState(() => planningValue = newSliderValue);
                  },
                  min: 0,
                  max: 20,
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
              )),
              Container(
                width: 200.0,
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.top,
                  maxLength: 160,
                  maxLengthEnforced: true,
                  maxLines: 10,
                  controller: planning,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                  onSaved: (String value) {},
                  validator: RequiredValidator(
                      errorText: "Adheres to debrief format is required"),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Opacity(
                      opacity: 0.0,
                      child: ElevatedButton(
                        child: Text('Prev'),
                        onPressed: () async {},
                      ),
                    ),
                    ElevatedButton(
                      child: Text('Save'),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('planning', planning.text);
                        prefs.setString('planningValue', planningValue.round().toString());
                        saveNotification(context);
                      },
                    ),
                    ElevatedButton(
                      child: Text('Next'),
                      onPressed: () async {
                        navigation.currentState.pushNamed('/communication');
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
