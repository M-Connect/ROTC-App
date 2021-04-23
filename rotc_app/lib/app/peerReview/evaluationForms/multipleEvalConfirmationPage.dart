import 'package:flutter/material.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';


/*
  Author:  Kyle Serruys
 This page has the user select which evaluation date and evaluation activity to use for the
 evaluation.
  */
class MultipleEvalConfirmationPage extends StatefulWidget {
  @override
  _MultipleEvalConfirmationPageState createState() => _MultipleEvalConfirmationPageState();
}

class _MultipleEvalConfirmationPageState extends State<MultipleEvalConfirmationPage> {
  var usersToEvaluate = new List<String>();
  String userDisplayString;
  var selectedActivityList = new List<String>();
  String selectedActivityString;

  //DateTime evaluationCompletionDate = DateTime.now();
  String text;
  String tempString = "";
  String evalDate = "";

  TextEditingController chooseDate = TextEditingController();
  TextEditingController chooseActivity = TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    makeTextBlank();
    getSelectedUser();
    getSelectedActivity();
    getEvaluationDate();
  }

  //Author:  Kyle Serruys
  //Sets the evalDate and Eval activity to a blank box if nothing is selected
  makeTextBlank(){
    if(selectedActivityString == null){
      selectedActivityString = tempString;
    }
  }
//Author:  Kyle Serruys
  //gets the activity name from shared preferences
  getSelectedActivity() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedActivityList = prefs.getStringList("selectedActivityList".toString());
      selectedActivityString = prefs.getStringList("selectedActivityList").reduce((value, element) => value + element);
    });
  }
//Author:  Kyle Serruys
  //gets the user name from shared preferences
  getSelectedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

      userDisplayString = prefs.getStringList("usersToEvaluate").join(", ");
    });
  }
  //Author:  Kyle Serruys
  //gets the evaluation date from shared preferences
  getEvaluationDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      evalDate = prefs.getString('evaluationDate') ?? " ";
      var formattedEvalDate = evalDate.substring(0,10);
      evalDate = formattedEvalDate;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('selectedUserList');
            prefs.remove('selectedActivityList');
            prefs.remove('evaluationDate');
            navigation.currentState.pushNamed('/peerReviewRequest');
          },
        ),
        title: Text('Request'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.logout),
              onPressed: () {
                alertSignOut(context);
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 75,
                padding: (EdgeInsets.all(5.0)),
                decoration: BoxDecoration(
                  border: (Border.all(color: Colors.black87)),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        child: Text('$userDisplayString to be under evaluation',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(left: 25.0),

                        child: Text(
                          'Evaluation Date:',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                //width: 250,
                padding: EdgeInsets.all(25.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SizedBox(
                          //  width: 250,
                          child: TextField(
                            readOnly: true,
                            controller: chooseDate,
                            decoration: InputDecoration(
                              hintText: (evalDate),
                              hintStyle: TextStyle(
                                  fontSize: 20.0, color: Colors.black87),
                              isDense: true,
                              contentPadding: EdgeInsets.all(8.0),
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(5.0),
                                ),
                              ),
                            ),
                            onTap: () async{
                              await navigation.currentState.pushNamed('/evaluationCalendarTasks');
                              getEvaluationDate();
                            },
                          ),
                        ),
                      ),
                    ]),
              ),

              Container(
                child: Row(
                  children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.only(left: 25.0),

                        child: Text(
                          'Evaluation Activity:',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),
              Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: Container(

                            padding: EdgeInsets.all(25.0),
                            child: TextField(
                              readOnly: true,
                              controller: chooseActivity,
                              decoration: InputDecoration(
                                hintText: (selectedActivityString),
                                hintStyle: TextStyle(
                                    fontSize: 20.0, color: Colors.black87),
                                isDense: true,
                                contentPadding: EdgeInsets.all(8.0),
                                prefixIcon: Icon(Icons.search),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(5.0),
                                  ),
                                ),
                              ),
                              onTap: () {
                                navigation.currentState.pushNamed('/multipleUserActivityToBeEvaluated');
                              },
                              //  onChanged: chooseDate,
                            ),
                          ),
                        ),
                      ),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
              ),
              Container(
                width: 200,
                height: 40,
                child: ElevatedButton(
                  child: Text('Next'),
                  onPressed: () {
                    if(evalDate.isEmpty || evalDate == null || selectedActivityString==null||selectedActivityString.isEmpty){
                      alertDialog(context);
                    }else {
                      navigation.currentState.pushNamed('/usersToDoEvaluation');
                    }

                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


Future <void> alertDialog(BuildContext context) async {
  Widget button = ElevatedButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text("Evaluation Date and Evaluation Activity is Required."),
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