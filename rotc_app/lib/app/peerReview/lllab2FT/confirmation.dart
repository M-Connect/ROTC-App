import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';

class Confirmation extends StatefulWidget {
  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  String planning = "";
  String communication = "";
  String execution = "";
  String leadership = "";
  String debrief = "";
  String planningValue = "";
  String communicationValue = "";
  String executionValue = "";
  String leadershipValue = "";
  String debriefValue = "";
  String firstName = "";
  String lastName ="";

  CollectionReference evaluation =
      FirebaseFirestore.instance.collection('peerEvaluation');

  CollectionReference evaluationRequests = FirebaseFirestore.instance.collection('userEvaluationRequests');

  Future<void> markEvaluationComplete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var evaluationId = prefs.getString("currentEvaluationId");
    evaluationRequests.doc(evaluationId).update({
      "status":"Complete"
    });
  }

  Future<void> peerEvaluation() {
    return evaluation.add({
      "firstName": firstName,
      "lastName": lastName,
      "planning": planning,
      "planningValue": planningValue,
      "communication": communication,
      "communicationValue": communicationValue,
      "execution": execution,
      "executionValue":executionValue,
      "leadership": leadership,
      "leadershipValue": leadershipValue,
      "debrief": debrief,
      "debriefValue":debriefValue,
    });
  }

  @override
  void initState() {
    getPlanningData();
    getCommunicationData();
    getLeadershipData();
    getExecutionData();
    getDebriefData();
    print("Confirmation" + this.planning);
  }

  getExecutionData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      execution = prefs.getString("execution");
      executionValue = prefs.getString("executionValue");
      firstName = prefs.getString("firstName");
      lastName = prefs.getString("lastName");
    });
  }

  getLeadershipData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      leadership = prefs.getString("leadership");
      leadershipValue = prefs.getString("leadershipValue");
    });
  }

  getCommunicationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      communication = prefs.getString("communication");
      communicationValue = prefs.getString("communicationValue");
    });
  }

  getPlanningData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      planning = prefs.getString("planning");
      planningValue = prefs.getString("planningValue");
    });
  }

  getDebriefData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      debrief = prefs.getString("debrief");
      debriefValue = prefs.getString("debriefValue");
    });
  }

  static final SizedBox spaceBetweenFields = SizedBox(height: 20.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Peer Review Confirmation'),
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
        child: Container(
          child: Column(
            children: [
              Row(
                children: [
                  Text('Evaluatee:  $firstName $lastName'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Planning:  $planningValue/20 points',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              Container(
                height: 75,
                padding: (EdgeInsets.all(5.0)),
                decoration: BoxDecoration(
                  border: (Border.all(color: Colors.black87)),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        planning ?? '',
                      ),
                    ),
                  ],
                ),
              ),
              spaceBetweenFields,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Communication:  $communicationValue/20 points',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              Container(
                height: 75,
                padding: (EdgeInsets.all(5.0)),
                decoration: BoxDecoration(
                  border: (Border.all(color: Colors.black87)),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        communication ?? '',
                      ),
                    ),
                  ],
                ),
              ),
              spaceBetweenFields,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Execution:  $executionValue/20 points',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              Container(
                height: 75,
                padding: (EdgeInsets.all(5.0)),
                decoration: BoxDecoration(
                  border: (Border.all(color: Colors.black87)),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(execution ?? ''),
                    ),
                  ],
                ),
              ),
              spaceBetweenFields,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Leadership:  $leadershipValue/20 points',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              Container(
                height: 75,
                padding: (EdgeInsets.all(5.0)),
                decoration: BoxDecoration(
                  border: (Border.all(color: Colors.black87)),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(leadership ?? ''),
                    ),
                  ],
                ),
              ),
              spaceBetweenFields,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Debrief:  $debriefValue/20 points',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              Container(
                height: 75,
                padding: (EdgeInsets.all(5.0)),
                decoration: BoxDecoration(
                  border: (Border.all(color: Colors.black87)),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(debrief ?? ''),
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
                    ElevatedButton(
                      child: Text('Edit'),
                      onPressed: () async {
                        navigation.currentState.pushNamed('/peerReviewLLAB2FT');
                      },
                    ),
                    ElevatedButton(
                      child: Text('Submit'),
                      onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        await markEvaluationComplete();
                        await peerEvaluation();
                        await prefs.remove("planning");
                        await prefs.remove("communication");
                        await prefs.remove("execution");
                        await prefs.remove("leadership");
                        await prefs.remove("debrief");
                        await prefs.remove("planningValue");
                        await prefs.remove("communicationValue");
                        await prefs.remove("executionValue");
                        await prefs.remove("leadershipValue");
                        await prefs.remove("debriefValue");
                        await prefs.remove("currentEvaluationId");

                        navigation.currentState.pushNamed('/homePage');
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
