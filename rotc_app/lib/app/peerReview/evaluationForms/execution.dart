import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';
import '../peerReviewLanding.dart';
/*
 Author: Kyle Serruys
  This class is the Execution page of our peer review
  Co-Author: Christine Thomas
  added the isCadre check to change the appBar Color depending on which
  type of user is signed in.
 */

class Execution extends StatefulWidget {
  Execution() : super();

  @override
  ExecutionState createState() => ExecutionState();
}

class ExecutionState extends State<Execution> {
  TextEditingController execution;
double executionValue;
String defaultExecutionValue = "0";
var currentEvaluationId = "";
bool isCadre = false;

  @override
  void initState() {
    super.initState();
    getUserInfo();
    initControllers();
    getBool();
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
      var executionValue = prefs.getString("execution");
      execution = TextEditingController(text: executionValue);
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
      var executionSliderValue = prefs.getString('executionValue') ?? defaultExecutionValue;
      executionValue = double.parse(executionSliderValue);
    });
  }
  initSliderValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      sliderChange(executionValue);
    });
  }
  //Author:  Kyle Serruys
  //This allows the value of the score to change when you slide the slider
  void sliderChange(double test) {
    setState(() {
      if(test != null){
        test = executionValue;
      }
    });
  }

  /*
  Author:  Kyle Serruys
  This method saves your progress, so if you hit back and forth or even exit out of the app,
  it will keep the latest information entered saved into the database.

  */
  Future<void> saveProgress() async{
    CollectionReference evaluation =
    FirebaseFirestore.instance.collection('peerEvaluation');
    SharedPreferences prefs = await SharedPreferences.getInstance();

    evaluation.doc(currentEvaluationId).set({
      "evaluationDate": DateTime.now().toString(),
      "planning": prefs.getString(("planning")),
      "planningValue": prefs.getString("planningValue"),
      "communication": prefs.getString("communication"),
      "communicationValue": prefs.getString("communicationValue"),
      "execution": execution.text,
      "executionValue":executionValue.round().toString(),
      "leadership": prefs.getString("leadership"),
      "leadershipValue": prefs.getString("leadershipValue"),
      "debrief": prefs.getString("debrief"),
      "debriefValue":prefs.getString("debriefValue"),
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
        title: Text('Execution'),
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
                          child: Text(executionValue.round().toString(),style: TextStyle(fontSize: 25.0, ),),
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
                      child: Text('0',style: TextStyle(fontSize: 25.0, ),),
                      flex: 2,
                    ),
                    Expanded(
                      child: Slider(
                        value: executionValue,
                        onChanged: (newSliderValue) {
                          setState(() => executionValue = newSliderValue);
                        },
                        min: 0,
                        max: 20,
                      ),
                      flex: 19,
                    ),
                    Expanded(
                      child: Text("20",style: TextStyle(fontSize: 25.0, ),),
                      flex:2,
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
                      child: Text('Evaluator Notes:',style: TextStyle(fontSize: 25.0, ),),
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
                  controller: execution,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding:


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
                      child: Text("Hint:\n-Time Management\n-Resource Management\n-Flexibility\n-Mission Success",style: TextStyle(fontSize: 18.0, ),),
                      flex:8,
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
                        prefs.setString('execution', execution.text);
                        prefs.setString(
                            'executionValue', executionValue.round().toString());
                       await saveProgress();
                        if (execution.text.isEmpty) {
                          alertDialog(context);
                        } else {
                          navigation.currentState.pushNamed('/communication');
                        }
                      },
                    ),

                    ElevatedButton(
                      child: Text('Next'),
                      onPressed: () async {
                        SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        prefs.setString('execution', execution.text);
                        prefs.setString(
                            'executionValue', executionValue.round().toString());
                        await saveProgress();
                        if (execution.text.isEmpty) {
                          alertDialog(context);
                        } else {
                          navigation.currentState.pushNamed('/leadership');
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
Future<void> alertDialog(BuildContext context) {
  Widget button = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text("Execution Notes are Required."),
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
