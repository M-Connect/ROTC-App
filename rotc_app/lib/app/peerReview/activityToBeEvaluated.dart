import 'package:flutter/material.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:rotc_app/app/peerReview/peerReviewLanding.dart';

import '../../main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
 Author: Kyle Serruys
 This class allows the evaluator to evaluate the evaluatee on a certain activity.
 It pulls from all activites listed in the database, as well as gives the option
 to add a new activity.
    Co-Author: Christine Thomas
  added the isCadre check to change the appBar Color depending on which
  type of user is signed in.

 */

class ActivityToBeEvaluated extends StatefulWidget {
  @override
  ActivityToBeEvaluatedState createState() => ActivityToBeEvaluatedState();
}

class ActivityToBeEvaluatedState extends State<ActivityToBeEvaluated> {
  var activityList = new List<String>();
  var filteredActivityList = new List<String>();
  var selectedActivityList = new List<String>();
  var tempList = new List<String>();


  bool isListEmpty = true;
  bool isCadre = false;

  TextEditingController activitySearch = TextEditingController();

  List<ElevatedButton> activityButtonList = new List<ElevatedButton>();
  String activity = "";

  CollectionReference activities = FirebaseFirestore.instance.collection('activity');

  Future<void> activityRegistration()  {
    return activities.add({
      'activity': activitySearch.text,
    });
  }

  @override
  void initState() {
    super.initState();
    getActivity();
    getActivityInfo();
    getBool();
  }

  getActivity() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      activity = prefs.getString("activity");
    });
  }

/*
Author:  Kyle Serruys
This is the function used to take a snapshot of our collection and import the
first and last name of the users in the users collection.
  */
  getActivityInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await FirebaseFirestore.instance
        .collection('activity').orderBy("activity")
        .get()
        .then((docSnapshot) {
      docSnapshot.docs.forEach((element) {
        activityList.add(element.data()['activity'].toString());
      });
    });
    setState(() {
      searchList("");
    });
  }

  /*
  Author:  Kyle Serruys
  This list takes the users from our users collection and adds a button with
  their name on it.  This will populate for each and every user in the users
  collection.
  Co-Author: Sawyer Kisha
  Formatted the list of cadets for the interface

  */
  List<Widget> makeButtonsList() {
    activityButtonList.clear();
    for (int i = 0; i < filteredActivityList.length; i++) {
      activityButtonList.add(
        new ElevatedButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            selectedActivityList.add(filteredActivityList[i]);
            prefs.setStringList('selectedActivityList', selectedActivityList);
            navigation.currentState
                .pushNamed('/individualEvalConfirmationPage');
          },
          child: Container(
              width: 200,
              height: 40,
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Text(filteredActivityList[i])])),
        ),
      );
    }
    return activityButtonList;
  }

  searchList(String value) {
    var filter = activitySearch.value.text;
    setState(() {
      if(filter == "" || filter == null)
      {
        filteredActivityList = activityList;

      }
      else{
        filteredActivityList = activityList
            .where(
                (element) => element.toLowerCase().contains(filter.toLowerCase()))
            .toList();
      }
      isListEmpty = filteredActivityList.length == 0;

    });
  }

  getBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isCadre = prefs.getString('isCadre') == 'true';
    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isCadre ? Color(0xFF031f72) : Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('selectedActivityList');
            navigation.currentState.pushNamed('/individualEvalConfirmationPage');
          },
        ),
        title: Text('Evaluation Activity'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.logout),
              onPressed: () {
                alertSignOut(context);
              }),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 50.0, bottom: 50.0),
                    child: Container(
                      child: Text(
                        'Select from an activity below, or add a new activity:',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    )),
                TextField(
                  controller: activitySearch,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                  ),
                  onChanged: searchList,
                ),
                if (tempList != null)
                  SizedBox(
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.all(12.0),
                      children: tempList?.map((value) {
                        return ListTile(
                          title: Text(value),
                          onTap: () async {
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            prefs.setStringList('selectedActivityList', selectedActivityList);
                            navigation.currentState
                                .pushNamed('/individualEvalConfirmationPage');
                          },
                        );
                      })?.toList(),
                    ),
                  ),
                Center(
                  child: Column(
                    children: makeButtonsList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 40.0),
                ),
                Visibility(
                  visible: isListEmpty,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: ElevatedButton(
                          child: Text("Add",),
                          onPressed: ()async {
                            activityRegistration();
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            selectedActivityList.add(activitySearch.text);
                            prefs.setStringList('selectedActivityList', selectedActivityList);
                            navigation.currentState.pushNamed('/individualEvalConfirmationPage');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}
