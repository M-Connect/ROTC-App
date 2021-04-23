import 'package:flutter/material.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import '../../../main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
Author: Kyle Serruys
  This page will load the users evaluations that have been performed on them.
  You will be able to search by either date or activity name.  After the activity
  has been chosen it will send you to the bar graph page.
 */

class GraphActivitySelector extends StatefulWidget {
  @override
  GraphActivitySelectorState createState() => GraphActivitySelectorState();
}

class GraphActivitySelectorState extends State<GraphActivitySelector> {
  var activityList = <String>[];
  var filteredActivityList = <String>[];
  var selectedActivityList = <String>[];
  var tempList = <String>[];

  bool isListEmpty = true;

  TextEditingController activitySearch = TextEditingController();

  List<ElevatedButton> activityButtonList = <ElevatedButton>[];
  String activity = "";

  CollectionReference activities = FirebaseFirestore.instance.collection('activity');



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
        .collection('peerEvaluation')
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
                .pushNamed('/barGraphy2');
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
        isListEmpty = false;
      }
      else{
        filteredActivityList = activityList
            .where(
                (element) => element.toLowerCase().contains(filter.toLowerCase()))
            .toList();
        isListEmpty = true;
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
            Navigator.pop(context);
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
                          child: Text("Submit",),
                          onPressed: ()async {
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
