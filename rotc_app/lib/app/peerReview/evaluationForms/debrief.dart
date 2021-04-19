import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';

/*
 Author: Kyle Serruys
  This class is the Debrief page of our peer review
  Co-Author: Christine Thomas
  added the isCadre check to change the appBar Color depending on which
  type of user is signed in.
 */
class Debrief extends StatefulWidget {
  Debrief() : super();

  @override
  DebriefState createState() => DebriefState();
}

class DebriefState extends State<Debrief> {
  TextEditingController debrief;

double debriefValue;
String defaultDebriefValue = "10";
var currentEvaluationId = "";
bool isCadre = false;

  @override
  void initState() {
    super.initState();
    getUserInfo();
    initSliderValue();
    initControllers();
    getBool();
  }

  initControllers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentEvaluationId = prefs.getString("currentEvaluationId");
      var debriefValue = prefs.getString("debrief");
      debrief = TextEditingController(text: debriefValue);
    });
  }

  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var debriefSliderValue = prefs.getString('debriefValue') ?? defaultDebriefValue;
      debriefValue = double.parse(debriefSliderValue);
    });
  }

  initSliderValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      sliderChange(debriefValue);
    });
  }
  void sliderChange(double test) {
    setState(() {
      if(test != null){
        test = debriefValue;
      }
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
      "executionValue":prefs.getString("executionValue"),
      "leadership": prefs.getString("leadership"),
      "leadershipValue": prefs.getString("leadershipValue"),
      "debrief": debrief.text,
      "debriefValue":debriefValue.round().toString(),
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
        title: Text('Debrief'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
            onPressed: () { alertSignOut(context);},
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
                          child: Text(debriefValue.round().toString(),style: TextStyle(fontSize: 25.0, ),),
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
                        value: debriefValue,
                        onChanged: (newSliderValue) {
                          setState(() => debriefValue = newSliderValue);
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
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text("Hint:\n-Adheres to Debrief Format\n-Receptive to Feedback\n-Improvement Oriented\n",style: TextStyle(fontSize: 18.0, ),),
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
                        prefs.setString('debrief', debrief.text);
                        prefs.setString('debriefValue', debriefValue.round().toString());
                        await saveProgress();
                        navigation.currentState.pushNamed('/leadership');
                      },
                    ),

                    ElevatedButton(
                      child: Text('Confirm'),
                      onPressed: () async {
                        SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        prefs.setString('debrief', debrief.text);
                        prefs.setString('debriefValue', debriefValue.round().toString());
                        await saveProgress();
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

