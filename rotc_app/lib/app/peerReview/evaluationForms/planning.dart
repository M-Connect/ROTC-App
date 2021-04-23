import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
/*
 Author: Kyle Serruys
  This class is the Planning page of our peer review
     Co-Author: Christine Thomas
  added the isCadre check to change the appBar Color depending on which
  type of user is signed in.

 */

class Planning extends StatefulWidget {
  Planning() : super();

  @override
  PlanningState createState() => PlanningState();
}

class PlanningState extends State<Planning> {
  TextEditingController planning;

  String firstName = "";
  String lastName = "";
  String emailAddress = "";
  String nickname = "";
  bool isCadre = false;
  double planningValue;
  String defaultPlanningValue = "0";
  var currentEvaluationId = "";

  @override
  void initState() {
    super.initState();
    initControllers();
    getUserInfo();
    initSliderValue();
    getBool();
  }

  initControllers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentEvaluationId = prefs.getString("currentEvaluationId");
      var planningTextValue = prefs.getString("planning");
      planning = TextEditingController(text: planningTextValue);
    });
  }

  initSliderValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      sliderChange(planningValue);
    });
  }

  void sliderChange(double test) {
    setState(() {
      if (test != null) {
        test = planningValue;
      }
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

      var planningSliderValue =
          prefs.getString('planningValue') ?? defaultPlanningValue;
      planningValue = double.parse(planningSliderValue);
    });
  }

  getBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isCadre = prefs.getString('isCadre') == 'true';
    });
  }

  Future<void> saveProgress() async {
    CollectionReference evaluation =
        FirebaseFirestore.instance.collection('peerEvaluation');

    SharedPreferences prefs = await SharedPreferences.getInstance();

    evaluation.doc(currentEvaluationId).set({
      "evaluationDate": DateTime.now().toString(),
      "planning": planning.text,
      "planningValue": planningValue.round().toString(),
      "communication": prefs.getString("communication"),
      "communicationValue": prefs.getString("communicationValue"),
      "execution": prefs.getString("execution"),
      "executionValue": prefs.getString("executionValue"),
      "leadership": prefs.getString("leadership"),
      "leadershipValue": prefs.getString("leadershipValue"),
      "debrief": prefs.getString("debrief"),
      "debriefValue": prefs.getString("debriefValue"),
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
                            planningValue.round().toString(),
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
                        value: planningValue,
                        onChanged: (newSliderValue) {
                          setState(() => planningValue = newSliderValue);
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
                mainAxisAlignment: MainAxisAlignment.center,
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
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        "Hint:\n-Team Organization\n-Outside Preparation\n-Mission Focus\n-Creativity",
                        style: TextStyle(fontSize: 18.0),
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
                  children: <Widget>[
                    Opacity(
                      opacity: 0.0,
                      child: ElevatedButton(
                        child: Text('Prev'),
                        onPressed: () async {},
                      ),
                    ),
                    ElevatedButton(
                      child: Text('Next'),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('planning', planning.text);
                        prefs.setString(
                            'planningValue', planningValue.round().toString());
                        await saveProgress();
                        if (planning.text.isEmpty) {
                          alertDialog(context);
                        } else {
                          navigation.currentState.pushNamed('/communication');
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
    content: Text("Planning Notes are Required."),
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
