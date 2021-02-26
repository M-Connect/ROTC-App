import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';

class Confirmation extends StatefulWidget {
  @override
  _ConfirmationState createState() => _ConfirmationState();
}

class _ConfirmationState extends State<Confirmation> {
  String teamOrganization = "";
  String outsidePreparation = "";
  String missionFocus = "";
  String creativity = "";
  String chainOfCommand = "";
  String situationalAwareness = "";
  String timeManagement = "";
  String resourcesManagement = "";
  String flexibility = "";
  String missionSuccess = "";
  String commandPresence = "";
  String delegation = "";
  String empowerment = "";
  String maintainsControl = "";
  String adheresToDebriefFormat = "";
  String receptiveToFeedback = "";
  String improvementOriented = "";
  String planningValueA = "";
  String planningValueB = "";
  String planningValueC = "";
  String planningValueD = "";
  String communicationValueA = "";
  String communicationValueB = "";
  String executionValueA = "";
  String executionValueB = "";
  String executionValueC = "";
  String executionValueD = "";
  String leadershipValueA = "";
  String leadershipValueB = "";
  String leadershipValueC = "";
  String leadershipValueD = "";
  String debriefValueA = "";
  String debriefValueB = "";
  String debriefValueC = "";


  CollectionReference llab2ftPeerReview =
  FirebaseFirestore.instance.collection('llab2ftPeerReview');

  Future<void> peerReview() {
    return llab2ftPeerReview.add({
      "teamOrganization": teamOrganization,
      "outsidePreparation": outsidePreparation,
      "missionFocus":missionFocus,
      "creativity":creativity,
      "chainOfCommand":chainOfCommand,
      "situationalAwareness":situationalAwareness,
      "timeManagement":timeManagement,
      "resourcesManagement":resourcesManagement,
      "flexibility":flexibility,
      "missionSuccess":missionSuccess,
      "commandPresence":commandPresence,
      "delegation":delegation,
      "empowerment":empowerment,
      "maintainsControl":maintainsControl,
      "adheresToDebriefFormat":adheresToDebriefFormat,
      "receptiveToFeedback":receptiveToFeedback,
      "improvementOriented":improvementOriented
    });
  }

  @override
  void initState() {
    getPlanningData();
    getCommunicationData();
    getLeadershipData();
    getExecutionData();
    getDebriefData();
  }

  getExecutionData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

      timeManagement = prefs.getString("timeManagement");
      resourcesManagement = prefs.getString("resourcesManagement");
      flexibility = prefs.getString("flexibility");
      missionSuccess = prefs.getString("missionSuccess");
      executionValueA = prefs.getString("executionValueA");
      executionValueB = prefs.getString("executionValueB");
      executionValueC = prefs.getString("executionValueC");
      executionValueD = prefs.getString("executionValueD");

    });
  }

  getLeadershipData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      commandPresence = prefs.getString("commandPresence");
      delegation = prefs.getString("delegation");
      empowerment = prefs.getString("empowerment");
      maintainsControl = prefs.getString("maintainsControl");
      leadershipValueA = prefs.getString("leadershipValueA");
      leadershipValueB = prefs.getString("leadershipValueB");
      leadershipValueC = prefs.getString("leadershipValueC");
      leadershipValueD = prefs.getString("leadershipValueD");
    });
  }

  getCommunicationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      chainOfCommand = prefs.getString("chainOfCommand");
      situationalAwareness = prefs.getString("situationalAwareness");
      communicationValueA = prefs.getString("communicationValueA");
      communicationValueB = prefs.getString("communicationValueB");
    });
  }

  getPlanningData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      teamOrganization = prefs.getString("teamOrganization");
      outsidePreparation = prefs.getString("outsidePreparation");
      missionFocus = prefs.getString("missionFocus");
      creativity = prefs.getString("creativity");
      planningValueA = prefs.getString("planningValueA");
      planningValueB = prefs.getString("planningValueB");
      planningValueC = prefs.getString("planningValueC");
      planningValueD = prefs.getString("planningValueD");
    });
  }

  getDebriefData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      adheresToDebriefFormat = prefs.getString("adheresToDebriefFormat");
      receptiveToFeedback = prefs.getString("receptiveToFeedback");
      improvementOriented = prefs.getString("improvementOriented");
      debriefValueA = prefs.getString("debriefValueA");
      debriefValueB = prefs.getString("debriefValueB");
      debriefValueC = prefs.getString("debriefValueC");
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
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Container(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Planning',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              Container(
                padding: (EdgeInsets.all(5.0)),
                decoration: BoxDecoration(
                  border: (Border.all(color: Colors.black87)),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          child: Text('Notes'),
                        ),
                        Container(
                          child: Text(teamOrganization ?? ''),
                        ),
                        Container(
                          child: Text(outsidePreparation ?? ''),
                        ),
                        Container(
                          child: Text(missionFocus ?? ''),
                        ),
                        Container(
                          child: Text(creativity ?? ''),
                        ),
                        Container(
                          child: Text('Total Score'),
                        ),
                      ],
                    ),
                    Column(

                      children: [
                        Container(
                          child: Text('Score'),
                        ),
                        Container(
                          child: Text(planningValueA ?? ''),
                        ),
                        Container(
                          child: Text(planningValueB ?? ''),
                        ),
                        Container(
                          child: Text(planningValueC ?? ''),
                        ),
                        Container(
                          child: Text(planningValueD ?? ''),
                        ),
                        Container(
                          child: Text('totalScore'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              spaceBetweenFields,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Communication',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              Container(
                padding: (EdgeInsets.all(5.0)),
                decoration: BoxDecoration(
                  border: (Border.all(color: Colors.black87)),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text('Notes'),
                        ),
                        Container(
                          child: Text(chainOfCommand ?? ''),
                        ),
                        Container(
                          child: Text(situationalAwareness ?? ''),
                        ),
                        Container(
                          child: Text('Total Score'),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          child: Text('Score'),
                        ),
                        Container(
                          child: Text(communicationValueA ?? ''),
                        ),
                        Container(
                          child: Text(communicationValueB ?? ''),
                        ),

                        Container(
                          child: Text('totalScore'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              spaceBetweenFields,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Execution',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              Container(
                padding: (EdgeInsets.all(5.0)),
                decoration: BoxDecoration(
                  border: (Border.all(color: Colors.black87)),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text('Notes'),
                        ),
                        Container(
                          child: Text(timeManagement ?? ''),
                        ),
                        Container(
                          child: Text(resourcesManagement ?? ''),
                        ),
                        Container(
                          child: Text(flexibility ?? ''),
                        ),
                        Container(
                          child: Text(missionSuccess ?? ''),
                        ),
                        Container(
                          child: Text('Total Score'),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          child: Text('Score'),
                        ),
                        Container(
                          child: Text(executionValueA ?? ''),
                        ),
                        Container(
                          child: Text(executionValueB ?? ''),
                        ),
                        Container(
                          child: Text(executionValueC ?? ''),
                        ),
                        Container(
                          child: Text(executionValueD ?? ''),
                        ),
                        Container(
                          child: Text('totalScore'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              spaceBetweenFields,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Leadership',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              Container(
                padding: (EdgeInsets.all(5.0)),
                decoration: BoxDecoration(
                  border: (Border.all(color: Colors.black87)),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            'Notes',
                          ),
                        ),
                        Container(
                          child: Text(commandPresence ?? ''),
                        ),
                        Container(
                          child: Text(delegation ?? ''),
                        ),
                        Container(
                          child: Text(empowerment ?? ''),
                        ),
                        Container(
                          child: Text(maintainsControl ?? ''),
                        ),
                        Container(
                          child: Text('Total Score'),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          child: Text('Score'),
                        ),
                        Container(
                          child: Text(leadershipValueA ?? ''),
                        ),
                        Container(
                          child: Text(leadershipValueB ?? ''),
                        ),
                        Container(
                          child: Text(leadershipValueC ?? ''),
                        ),
                        Container(
                          child: Text(leadershipValueD ?? ''),
                        ),
                        Container(
                          child: Text('totalScore'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              spaceBetweenFields,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Debrief',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ],
              ),
              Container(
                padding: (EdgeInsets.all(5.0)),
                decoration: BoxDecoration(
                  border: (Border.all(color: Colors.black87)),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text('Notes'),
                        ),
                        Container(
                          child: Text(adheresToDebriefFormat ?? ''),
                        ),
                        Container(
                          child: Text(receptiveToFeedback ?? ''),
                        ),
                        Container(
                          child: Text(improvementOriented ?? ''),
                        ),
                        Container(
                          child: Text('Total Score'),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          child: Text('Score'),
                        ),
                        Container(
                          child: Text(debriefValueA ?? ''),
                        ),
                        Container(
                          child: Text(debriefValueB ?? ''),
                        ),
                        Container(
                          child: Text(debriefValueC ?? ''),
                        ),

                        Container(
                          child: Text('totalScore'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.only(bottom: 40.0, left: 10.0, top: 40.0, right: 10.0),
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
                await peerReview();
                await prefs.remove("teamOrganization");
                await prefs.remove("outsidePreparation");
                await prefs.remove("missionFocus");
                await prefs.remove("creativity");
                await prefs.remove("chainOfCommand");
                await prefs.remove("situationalAwareness");
                await prefs.remove("timeManagement");
                await prefs.remove("resourcesManagement");
                await prefs.remove("flexibility");
                await prefs.remove("missionSuccess");
                await prefs.remove("commandPresence");
                await prefs.remove("delegation");
                await prefs.remove("empowerment");
                await prefs.remove("maintainsControl");
                await prefs.remove("adheresToDebriefFormat");
                await prefs.remove("receptiveToFeedback");
                await prefs.remove("improvementOriented");
                await prefs.remove("planningValueA");
                await prefs.remove("planningValueB");
                await prefs.remove("planningValueC");
                await prefs.remove("planningValueD");
                await prefs.remove("communicationValueA");
                await prefs.remove("communicationValueB");
                await prefs.remove("executionValueA");
                await prefs.remove("executionValueB");
                await prefs.remove("executionValueC");
                await prefs.remove("executionValueD");
                await prefs.remove("leadershipValueA");
                await prefs.remove("leadershipValueB");
                await prefs.remove("leadershipValueC");
                await prefs.remove("leadershipValueD");
                await prefs.remove("debriefValueA");
                await prefs.remove("debriefValueB");
                await prefs.remove("debriefValueC");



                navigation.currentState.pushNamed('/peerReviewLanding');
              },
            ),
          ],
        ),
      ),
    );
  }
}
