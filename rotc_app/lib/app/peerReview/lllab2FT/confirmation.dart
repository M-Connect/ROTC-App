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
    });
  }

  getLeadershipData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      commandPresence = prefs.getString("commandPresence");
      delegation = prefs.getString("delegation");
      empowerment = prefs.getString("empowerment");
      maintainsControl = prefs.getString("maintainsControl");
    });
  }

  getCommunicationData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      chainOfCommand = prefs.getString("chainOfCommand");
      situationalAwareness = prefs.getString("situationalAwareness");
    });
  }

  getPlanningData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      teamOrganization = prefs.getString("teamOrganization");
      outsidePreparation = prefs.getString("outsidePreparation");
      missionFocus = prefs.getString("missionFocus");
      creativity = prefs.getString("creativity");
    });
  }

  getDebriefData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      adheresToDebriefFormat = prefs.getString("adheresToDebriefFormat");
      receptiveToFeedback = prefs.getString("receptiveToFeedback");
      improvementOriented = prefs.getString("improvementOriented");
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
                          child: Text("1"),
                        ),
                        Container(
                          child: Text("2"),
                        ),
                        Container(
                          child: Text('3'),
                        ),
                        Container(
                          child: Text('4'),
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
                          child: Text('1'),
                        ),
                        Container(
                          child: Text('2'),
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
                          child: Text('1'),
                        ),
                        Container(
                          child: Text('2'),
                        ),
                        Container(
                          child: Text('3'),
                        ),
                        Container(
                          child: Text('4'),
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
                          child: Text('1'),
                        ),
                        Container(
                          child: Text('2'),
                        ),
                        Container(
                          child: Text('3'),
                        ),
                        Container(
                          child: Text('4'),
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
                          child: Text('1'),
                        ),
                        Container(
                          child: Text('2'),
                        ),
                        Container(
                          child: Text('3'),
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
                await peerReview();
                SharedPreferences prefs = await SharedPreferences.getInstance();

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

                navigation.currentState.pushNamed('/peerReviewLanding');
              },
            ),
          ],
        ),
      ),
    );
  }
}
