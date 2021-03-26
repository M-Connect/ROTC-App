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
 */

class MultipleUserActivityToBeEvaluated extends StatefulWidget {
  @override
  MultipleUserActivityToBeEvaluatedState createState() => MultipleUserActivityToBeEvaluatedState();
}

class MultipleUserActivityToBeEvaluatedState extends State<MultipleUserActivityToBeEvaluated> {
  var activityList = new List<String>();
  var filteredActivityList = new List<String>();
  var selectedActivityList = new List<String>();
  var tempList = new List<String>();

  bool isListEmpty = true;

  TextEditingController activitySearch = TextEditingController();

  List<ElevatedButton> activityButtonList = new List<ElevatedButton>();
  String activity = "";

  CollectionReference activities = FirebaseFirestore.instance.collection('activity');

  Future<void> activityRegistration()  {
    return activities.add({
      'activity': activitySearch.text,
    });
  }

/*
Author:  Kyle Serruys
This sets the state for the functions getCadetNames and getUserInfo.  We put
them in this initState becuase both functions need to be async, and you can't
make initState an async function.
  */
  @override
  void initState() {
    super.initState();
    getActivity();
    getActivityInfo();
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
        .collection('activity')
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

  searchList(String value) {
    var filter = activitySearch.value.text;
    setState(() {
      if(filter == "" || filter == null)
      {
        filteredActivityList = activityList;
        isListEmpty = true;
      }
      else{
        filteredActivityList = activityList
            .where(
                (element) => element.toLowerCase().contains(filter.toLowerCase()))
            .toList();
        isListEmpty = false;
      }

    });
  }


  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                            navigation.currentState.pushNamed('/multipleEvalConfirmationPage');
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
                          child: Text("Submit",),
                          onPressed: ()async {
                            activityRegistration();
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
