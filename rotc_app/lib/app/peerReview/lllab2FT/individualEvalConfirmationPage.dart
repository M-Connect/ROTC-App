import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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

CollectionReference evaluationRequests = FirebaseFirestore.instance.collection('userEvaluationRequests');

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
  String selectedUserString;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSelectedUser();
  }

  getSelectedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedUserList = prefs.getStringList("selectedUserList".toString());
     // selectedUserString = prefs.getStringList("selectedUserList").join();
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
        title: Text('Confirmation'),
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
                      child: Text(

                        '$selectedUserList Evaluation',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Text("Evaluation Date:"),
                    ),
                    Container(
                      child: Text("Insert Calendar Here"),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Text('Evaluation Activity:'),
                    ),
                    Container(
                      child: Text(
                        'insert activities here',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: ElevatedButton(
                  child: Text('Start Evaluation'),
                  onPressed: () async{
                    /*
                    * Insert into the userEvaluationRequests collection the evaluator name and the status*/
                    //get the user info to save and add it.


                    SharedPreferences prefs = await SharedPreferences.getInstance();

                    var userToEvaluate = selectedUserList.first;
                    var firstName = prefs.getString('firstName');
                    var lastName = prefs.getString('lastName');
                    var evaluator = firstName + lastName;
                    var docRef = await evaluationRequests.add({
                      "evaluator": evaluator,
                      "evaluatee": userToEvaluate,
                      "status":"Pending"
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