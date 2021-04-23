import 'package:flutter/material.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';

import '../../main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
 Author: Kyle Serruys
 This class allows the evaluator to evaluate the evaluatee on a certain activity.
 It pulls from all activites listed in the database, as well as gives the option
 to add a new activity.
 */

class ActivityToBeEvaluated extends StatefulWidget {
  @override
  ActivityToBeEvaluatedState createState() => ActivityToBeEvaluatedState();
}

class ActivityToBeEvaluatedState extends State<ActivityToBeEvaluated> {
  var activityList = <String>[];
  var filteredActivityList = <String>[];
  var selectedActivityList = <String>[];
  // var tempList = new List<String>();
  var pagedActivityList = <String>[];

  bool isListEmpty = true;
  bool loading = false;

  TextEditingController activitySearch = TextEditingController();

  List<ElevatedButton> activityButtonList = <ElevatedButton>[];
  String activity = "";
  int activitesPerPage = 12;
  int page = 1;
  int bottomOutOfRange = 0;

  ScrollController scrollController;

  CollectionReference activities =
      FirebaseFirestore.instance.collection('activity');

  /*
 Author: Kyle Serruys
 This will add a user input activity to our database
 */
  Future<void> activityRegistration() {
    return activities.add({
      'activity': activitySearch.text,
    });
  }

  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    super.initState();
    getActivity();
    // getActivityInfo();
    getPagedActivitiesV2();
  }
/*
 Author: Kyle Serruys
This gets the activity from shared preferences
 */
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
/*    SharedPreferences prefs = */ await SharedPreferences.getInstance();
/*    var data = */ await FirebaseFirestore.instance
        .collection('activity')
        .orderBy("activity")
        .get()
        .then((docSnapshot) {
      docSnapshot.docs.forEach((element) {
        activityList.add(element.data()['activity'].toString());
      });
      getPagedActivities();
    });
    setState(() {
      searchList("");
    });
  }
  /*
 Author: Kyle Serruys
 This method takes activites and adds them to pages for our pagination.  In other words,
 everytime the user scrolls up, a new page gets made and shows new activities.
 */
  getPagedActivities() {
    var newActivities = activityList
        .skip((page - 1) * activitesPerPage)
        .take(activitesPerPage)
        .toList();
    if (newActivities.length > 0) {
      //showProgressIndicator(loading);
      // Duration(seconds:5);
      pagedActivityList.addAll(newActivities);
      page = page + 1;
    }
    loading = false;
  }
/*
 Author: Kyle Serruys
 This method orders the activities on the page by its name.
 It also sets up skipping the previous pages activities.
 */
  getPagedActivitiesV2() async {
    if (page == 1) {
    /*  var data = */ await FirebaseFirestore.instance
          .collection("activity")
          .limit(activitesPerPage)
          .get()
          .then((docSnapshot) {
        docSnapshot.docs.forEach((element) {
          pagedActivityList.add(element.data()['activity'].toString());
        });
      });
    } else {
    /*  var skipThese = */ await FirebaseFirestore.instance
          .collection('activity')
          .orderBy("activity")
          .limit((page - 1) * activitesPerPage)
          .get()
          .then((documentSnapshots) async {
        var startAfterThis =
            documentSnapshots.docs[documentSnapshots.docs.length - 1];

    /*    var nextPage = */ await FirebaseFirestore.instance
            .collection('activity')
            .orderBy("activity")
            .startAfterDocument(startAfterThis)
            .limit(activitesPerPage)
            .get()
            .then((docSnapshot) {
          docSnapshot.docs.forEach((element) {
            pagedActivityList.add(element.data()['activity'].toString());
          });
        });
      });
    }
    setState(() {
      page = page + 1;
      searchList("");
    });
  }

  /*
  Author:  Kyle Serruys
  This list takes the activities from our activities collection and adds a button with
  the activity on it.  This will populate for each and every activity in the activity
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
/*
 Author: Kyle Serruys
 This method creates a circular progress indicator to show while the next page of activities
 is being loaded on the screen.
 */
  Widget showProgressIndicator(bool show) {
    return Container(
        height: show ? 150 : 0,
        width: show ? 150 : 0,
        color: Colors.transparent,
        child: Center(
          child: new CircularProgressIndicator(
            backgroundColor: Colors.red,
          ),
        ));
  }
  /*
 Author: Kyle Serruys
 This method let's the signed in user search through the list of activities
 depending on what they type in, it adds that value to a new list that is filtered.
 This shows only the activities in the list whose value equals the letters typed in the search
 box.
 */
  searchList(String value) {
    var filter = activitySearch.value.text;
    setState(() {
      if (filter == "" || filter == null) {
        filteredActivityList = pagedActivityList;
      } else {
        filteredActivityList = pagedActivityList
            .where((element) =>
                element.toLowerCase().contains(filter.toLowerCase()))
            .toList();
      }
      isListEmpty = filteredActivityList.length == 0;
    });
  }
/*
 Author: Kyle Serruys
 This is the listener that listens for you scrolling up on the app.
 */
  _scrollListener() {
    if (scrollController.offset > 0.0 &&
        scrollController.position.maxScrollExtent > 0.0) {
      if (scrollController.offset >=
              scrollController.position.maxScrollExtent &&
          !scrollController.position.outOfRange) {
        if (++bottomOutOfRange >= 2) {
          bottomOutOfRange = 0;

          setState(() {
            // loading = true;
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return Dialog(
                  child: new Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      showProgressIndicator(true),
                      new Text("Loading"),
                    ],
                  ),
                );
              },
            );
            new Future.delayed(new Duration(milliseconds: 1500), () {
              getPagedActivitiesV2();
              searchList("");
              makeButtonsList();
              Navigator.pop(context); //pop dialog
            });
          });
        } else {
          scrollController.animateTo(scrollController.offset - 5,
              duration: Duration(milliseconds: 500), curve: Curves.easeIn);
        }
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('selectedActivityList');
            navigation.currentState
                .pushNamed('/individualEvalConfirmationPage');
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
        controller: scrollController,
        padding: EdgeInsets.all(25.0),
        child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: const EdgeInsets.only(
                        left: 20.0, top: 50.0, bottom: 20.0),
                    child: Container(
                      alignment: Alignment.center,
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

                Center(
                  child: Column(children: [
                    showProgressIndicator(loading),
                    Column(
                      children: makeButtonsList(),
                    )
                  ]),
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
                          child: Text(
                            "Add",
                          ),
                          onPressed: () async {
                            activityRegistration();
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            selectedActivityList.add(activitySearch.text);
                            prefs.setStringList(
                                'selectedActivityList', selectedActivityList);
                            navigation.currentState
                                .pushNamed('/individualEvalConfirmationPage');
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
