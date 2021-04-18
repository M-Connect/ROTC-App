import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';

/*
Author: Kyle Serruys
  Co-Author: Christine Thomas
  added the isCadre check to change the appBar Color depending on which
  type of user is signed in.
 */
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
  String email = "";
  String activity = "";
  var selectedUserList = new List<String>();
  var selectedActivityList = new List<String>();
  String selectedActivityString;
  String selectedUserString;
  String evalDate= "";
  String evaluationId="";
  bool isCadre = false;


  CollectionReference evaluation =
      FirebaseFirestore.instance.collection('peerEvaluation');

  CollectionReference evaluationRequests = FirebaseFirestore.instance.collection('userEvaluationRequests');

  Future<void> markEvaluationComplete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    evaluationId = prefs.getString("currentEvaluationId");
    evaluationRequests.doc(evaluationId).update({
      "status":"Complete"
    });
  }

  Future<void> peerEvaluation() {
    evaluation.doc(evaluationId).set({
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "evaluationDate": DateTime.now().toString(),
      "activity":selectedActivityString,
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
    getUserData();
    getSelectedUser();
    getSelectedActivity();
    getPlanningData();
    getCommunicationData();
    getLeadershipData();
    getExecutionData();
    getDebriefData();
    getBool();
  }

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString("firstName");
      lastName = prefs.getString("lastName");
      email = prefs.getString("email");
      evalDate = prefs.get("evaluationDate");

    });
  }

  getSelectedActivity() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedActivityString = prefs.getString("activity");
      /*selectedActivityList = prefs.getStringList("selectedActivityList".toString());
      selectedActivityString = prefs.getStringList("selectedActivityList").reduce((value, element) => value + element);*/
    });
  }

  getSelectedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedUserString = prefs.getString("evaluatee");
     /*selectedUserList = prefs.getStringList("selectedUserList".toString());
      selectedUserString = prefs
          .getStringList("selectedUserList")
          .reduce((value, element) => value + element);*/
    });
  }
  getExecutionData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      execution = prefs.getString("execution");
      executionValue = prefs.getString("executionValue");
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
  getBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isCadre = prefs.getString('isCadre') == 'true';
    });
  }
  static final SizedBox spaceBetweenFields = SizedBox(height: 20.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isCadre ? Color(0xFF031f72) : Colors.blue,
        automaticallyImplyLeading: false,
        title: Text('Evaluation Confirmation'),
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
                  Text('Evaluator:  $firstName $lastName', style: TextStyle(fontSize: 20.0),),
                ],
              ),
              Row(
                children: [
                  Text('Evaluatee:  $selectedUserString',style: TextStyle(fontSize: 20.0),),
                ],
              ),
              Row(
                children: [
                  Text('Activity:  $selectedActivityString', style: TextStyle(fontSize: 20.0),),
                ],
              ),
              Padding(padding: EdgeInsets.only(bottom: 20.0),),
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
                        await prefs.remove("selectedActivityList");
                        await prefs.remove("activity");
                        await prefs.remove("evaluationDate");


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
