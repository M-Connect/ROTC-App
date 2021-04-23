import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
/*
 Author: Kyle Serruys
  This class is the Leadership page of our peer review
  Co-Author: Christine Thomas
  added the isCadre check to change the appBar Color depending on which
  type of user is signed in.
 */

class Leadership extends StatefulWidget {
  Leadership() : super();

  @override
  LeadershipState createState() => LeadershipState();
}

class LeadershipState extends State<Leadership> {
  TextEditingController leadership;

  double leadershipValue;
  String defaultLeadershipValue = "0";
  var currentEvaluationId = "";
  bool isCadre = false;

  @override
  void initState() {
    super.initState();
    getUserInfo();
    initControllers();
    initSliderValue();
    getBool();
  }

  initControllers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentEvaluationId = prefs.getString("currentEvaluationId");
      var leadershipValue = prefs.getString("leadership");
      leadership = TextEditingController(text: leadershipValue);
    });
  }

  initSliderValue() async {
  /*  SharedPreferences prefs = */ await SharedPreferences.getInstance();
    setState(() {
      sliderChange(leadershipValue);
    });
  }

  void sliderChange(double test) {
    setState(() {
      if (test != null) {
        test = leadershipValue;
      }
    });
  }

  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var leadershipSliderValue =
          prefs.getString('leadershipValue') ?? defaultLeadershipValue;
      leadershipValue = double.parse(leadershipSliderValue);
    });
  }

  Future<void> saveProgress() async {
    CollectionReference evaluation =
        FirebaseFirestore.instance.collection('peerEvaluation');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    evaluation.doc(currentEvaluationId).set({
      "evaluationDate": DateTime.now().toString(),
      "planning": prefs.getString(("planning")),
      "planningValue": prefs.getString("planningValue"),
      "communication": prefs.getString("communication"),
      "communicationValue": prefs.getString("communicationValue"),
      "execution": prefs.getString("execution"),
      "executionValue": prefs.getString("executionValue"),
      "leadership": leadership.text,
      "leadershipValue": leadershipValue.round().toString(),
      "debrief": prefs.getString("debrief"),
      "debriefValue": prefs.getString("debriefValue"),
    });
  }

  getBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isCadre = prefs.getString('isCadre') == 'true';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isCadre ? Color(0xFF031f72) : Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () async {
            await saveProgress();
            navigation.currentState.pushNamed('/peerReviewLLAB2FT');
          },
        ),
        title: Text('Leadership'),
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
                          child: Text(
                            leadershipValue.round().toString(),
                            style: TextStyle(
                              fontSize: 25.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        '0',
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      flex: 2,
                    ),
                    Expanded(
                      child: Slider(
                        value: leadershipValue,
                        onChanged: (newSliderValue) {
                          setState(() => leadershipValue = newSliderValue);
                        },
                        min: 0,
                        max: 20,
                      ),
                      flex: 19,
                    ),
                    Expanded(
                      child: Text(
                        "20",
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                      flex: 2,
                    ),
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
                      child: Text(
                        'Evaluator Notes:',
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
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
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "Hint:\n-Confidence/Command Presence\n-Delegation\n-Empowerment\n-Maintains Control Over Situation",
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                      ),
                      flex: 8,
                    ),
                  ],
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
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('leadership', leadership.text);
                        prefs.setString('leadershipValue',
                            leadershipValue.round().toString());
                        await saveProgress();
                        if (leadership.text.isEmpty) {
                          alertDialog(context);
                        } else {
                          navigation.currentState.pushNamed('/execution');
                        }
                      },
                    ),
                    ElevatedButton(
                      child: Text('Next'),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('leadership', leadership.text);
                        prefs.setString('leadershipValue',
                            leadershipValue.round().toString());
                        await saveProgress();
                        if (leadership.text.isEmpty) {
                          alertDialog(context);
                        } else {
                          navigation.currentState.pushNamed('/debrief');
                        }
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
Future<void> alertDialog(BuildContext context) async {
  Widget button = ElevatedButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text("Leadership Notes are Required."),
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
