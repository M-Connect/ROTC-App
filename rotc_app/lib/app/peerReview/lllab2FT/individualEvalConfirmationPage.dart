
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';

/*
Author:  Kyle Serruys
After the user to be evaluated is selected you get sent to this page.
This will allow the user to choose a date for the evaluation as well as
the type of evaluation to be performed.  Upon clicking the start evaluation
button it will send you to the evaluation form.
*/

CollectionReference evaluationRequests =
    FirebaseFirestore.instance.collection('userEvaluationRequests');

/*
When you press sub
* */
class IndividualEvalConfirmationPage extends StatefulWidget {
  @override
  _IndividualEvalConfirmationPageState createState() =>
      _IndividualEvalConfirmationPageState();
}

class _IndividualEvalConfirmationPageState
    extends State<IndividualEvalConfirmationPage> {
  var selectedUserList = new List<String>();
  var selectedActivityList = new List<String>();
  String selectedActivityString;
  String selectedUserString;
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

  getEvaluationDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      evalDate = prefs.getString('evaluationDate') ?? " ";
  DateTime evaluationDate = new DateFormat("MM-dd-yyyy").parse(evalDate);
});


  }
  getSelectedActivity() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedActivityList = prefs.getStringList("selectedActivityList".toString());
      selectedActivityString = prefs.getStringList("selectedActivityList").reduce((value, element) => value + element);
    });
  }

  makeTextBlank(){
    if(selectedActivityString == null){
      selectedActivityString = tempString;
    }
  }

  getSelectedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedUserList = prefs.getStringList("selectedUserList".toString());
      selectedUserString = prefs
          .getStringList("selectedUserList")
          .reduce((value, element) => value + element);
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
            navigation.currentState.pushNamed('/peerReview');
          },
        ),
        title: Text('Confirmation Request'),
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
                /*decoration: BoxDecoration(
                  border: (Border.all(color: Colors.black87)),
                ),*/
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                 // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        child: Text(
                          '$selectedUserString Evaluation',
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
                            onTap: () async {
                              await navigation.currentState.pushNamed('/evaluationCalendarTasks');
                              getEvaluationDate();
                              //getEvaluationCompletionDate(context);
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
                                hintText: selectedActivityString,
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

                                navigation.currentState.pushNamed('/activityToBeEvaluated');
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
                child: ElevatedButton(
                  child: Text('Start Evaluation'),
                  onPressed: () async {
                    /*
                    * Insert into the userEvaluationRequests collection the evaluator name and the status*/
                    //get the user info to save and add it.

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();

                    var userToEvaluate = selectedUserList.first;
                    var firstName = prefs.getString('firstName');
                    var lastName = prefs.getString('lastName');
                    var evaluator = firstName + lastName;
                    var docRef = await evaluationRequests.add({
                      "evaluator": evaluator,
                      "evaluatee": userToEvaluate,
                      "status": "Pending"
                    });

                    //save id into shared prefs
                    var docId = docRef.id;
                    prefs.setString("currentEvaluationId", docId);
                    navigation.currentState.pushNamed('/peerReviewLLAB2FT');
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
