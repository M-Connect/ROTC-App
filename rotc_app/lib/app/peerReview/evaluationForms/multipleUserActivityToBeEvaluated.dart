import 'package:flutter/material.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import '../../../main.dart';
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

class MultipleUserActivityToBeEvaluated extends StatefulWidget {
  @override
  MultipleUserActivityToBeEvaluatedState createState() => MultipleUserActivityToBeEvaluatedState();
}

class MultipleUserActivityToBeEvaluatedState extends State<MultipleUserActivityToBeEvaluated> {
  var activityList = <String>[];
  var filteredActivityList = <String>[];
  var selectedActivityList = <String>[];
  var tempList = <String>[];

  var pagedActivityList = <String>[];

  bool isListEmpty = true;
  bool isCadre = false;
  bool loading = false;

  TextEditingController activitySearch = TextEditingController();

  List<ElevatedButton> activityButtonList = <ElevatedButton>[];
  String activity = "";
  int activitesPerPage = 12;
  int page = 1;
  int bottomOutOfRange = 0;

  ScrollController scrollController;

  CollectionReference activities = FirebaseFirestore.instance.collection('activity');

  Future<void> activityRegistration()  {
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
    getActivityInfo();
    getBool();
    getPagedActivitiesV2();
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
    //SharedPreferences prefs = await SharedPreferences.getInstance();
    //var data =
    await FirebaseFirestore.instance
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

  getPagedActivitiesV2() async {
    if (page == 1) {
      //var data =
      await FirebaseFirestore.instance
          .collection("activity")
          .limit(activitesPerPage)
          .get()
          .then((docSnapshot) {
        docSnapshot.docs.forEach((element) {
          pagedActivityList.add(element.data()['activity'].toString());
        });
      });
    } else {
      //var skipThese =
      await FirebaseFirestore.instance
          .collection('activity')
          .orderBy("activity")
          .limit((page - 1) * activitesPerPage)
          .get()
          .then((documentSnapshots) async {
        var startAfterThis =
        documentSnapshots.docs[documentSnapshots.docs.length - 1];

        //var nextPage =
        await FirebaseFirestore.instance
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
                .pushNamed('/multipleEvalConfirmationPage');
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


  searchList(String value) {
    var filter = activitySearch.value.text;
    setState(() {
      if(filter == "" || filter == null)
      {
        filteredActivityList = pagedActivityList;

      }
      else{
        filteredActivityList = pagedActivityList
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
        backgroundColor: isCadre ? Color(0xFF031f72) : Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('selectedActivityList');
            navigation.currentState.pushNamed('/multipleEvalConfirmationPage');
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
                          child: Text("Add",),
                          onPressed: ()async {
                            activityRegistration();
                            SharedPreferences prefs = await SharedPreferences.getInstance();
                            selectedActivityList.add(activitySearch.text);
                            prefs.setStringList('selectedActivityList', selectedActivityList);
                            navigation.currentState.pushNamed('/multipleEvalConfirmationPage');
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
