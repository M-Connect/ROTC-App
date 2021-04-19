import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';
/*
 Author: Kyle Serruys
  This class is the Communication page of our evaluation.  It will show the evalution
  data as well as score.
 */

class Communication extends StatefulWidget {
  Communication() : super();

  @override
  CommunicationState createState() => CommunicationState();
}

class CommunicationState extends State<Communication> {
  TextEditingController communication;

  double communicationValue;
  String defaultCommunicationValue = "0";
  var currentEvaluationId = "";

  @override
  void initState() {
    super.initState();
    initControllers();
    getUserInfo();
  }

  /*
  Author:  Kyle Serruys
  This gets the users evaluation Id, the evaluation data, and the score and value from shared
  preferences

  */
  initControllers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentEvaluationId = prefs.getString("currentEvaluationId");
      var communicationValue = prefs.getString("communication");
      communication = TextEditingController(text: communicationValue);
    });
  }

  //Author:  Kyle Serruys
  //This allows the value of the score to change when you slide the slider
  void sliderChange(double test) {
    setState(() {
      if (test != null) {
        test = communicationValue;
      }
    });
  }

  /*
  Author:  Kyle Serruys
  This gets the slider value from shared preferences, if none is selected
  it sets to the default value
   */
  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var communicationSliderValue =
          prefs.getString('communicationValue') ?? defaultCommunicationValue;
      communicationValue = double.parse(communicationSliderValue);
    });
  }

  /*
  Author:  Kyle Serruys
  This method saves your progress, so if you hit back and forth or even exit out of the app,
  it will keep the latest information entered saved into the database.

  */
  Future<void> saveProgress() async {
    CollectionReference evaluation =
        FirebaseFirestore.instance.collection('peerEvaluation');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    evaluation.doc(currentEvaluationId).set({
      "evaluationDate": DateTime.now().toString(),
      "planning": prefs.getString(("planning")),
      "planningValue": prefs.getString("planningValue"),
      "communication": communication.text,
      "communicationValue": communicationValue.round().toString(),
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
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () async {
            await saveProgress();
            navigation.currentState.pushNamed('/peerReviewLLAB2FT');
          },
        ),
        title: Text('Communication'),
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
                            communicationValue.round().toString(),
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
                        value: communicationValue,
                        onChanged: (newSliderValue) {
                          setState(() => communicationValue = newSliderValue);
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
                  controller: communication,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding:
                        // const EdgeInsets.symmetric(vertical: 75.0),

                        EdgeInsets.all(10.0),
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
                        "Hint:\n-Use of Chain of Command\n-Maintains Team's Situational Awareness\n\n",
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
                  children: [
                    ElevatedButton(
                      child: Text('Prev'),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('communication', communication.text);
                        prefs.setString('communicationValue',
                            communicationValue.round().toString());
                        await saveProgress();
                        if (communication.text.isEmpty) {
                          alertDialog(context);
                        } else {
                          navigation.currentState.pushNamed('/planning');
                        }
                      },
                    ),
                    /*ElevatedButton(
                      child: Text('Save'),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('communication', communication.text);
                        prefs.setString(
                            'communicationValue', communicationValue.round().toString());
                        saveNotification(context);
                      },
                    ),*/
                    ElevatedButton(
                      child: Text('Next'),
                      onPressed: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('communication', communication.text);
                        prefs.setString('communicationValue',
                            communicationValue.round().toString());
                        await saveProgress();
                        if (communication.text.isEmpty) {
                          alertDialog(context);
                        } else {
                          navigation.currentState.pushNamed('/execution');
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

Future<void> alertDialog(BuildContext context) {
  Widget button = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text("Communication Notes are Required."),
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
