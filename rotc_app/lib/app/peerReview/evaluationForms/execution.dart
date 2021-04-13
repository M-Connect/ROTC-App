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
 */

class Execution extends StatefulWidget {
  Execution() : super();

  @override
  ExecutionState createState() => ExecutionState();
}

class ExecutionState extends State<Execution> {
  TextEditingController execution;
double executionValue;
String defaultExecutionValue = "10";
var currentEvaluationId = "";
  @override
  void initState() {
    super.initState();
    getUserInfo();
    initControllers();
  }

  initControllers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentEvaluationId = prefs.getString("currentEvaluationId");
      var executionValue = prefs.getString("execution");
      execution = TextEditingController(text: executionValue);
    });
  }

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
  void sliderChange(double test) {
    setState(() {
      if(test != null){
        test = executionValue;
      }
    });
  }

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
                        navigation.currentState.pushNamed('/communication');
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
                        navigation.currentState.pushNamed('/leadership');
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
