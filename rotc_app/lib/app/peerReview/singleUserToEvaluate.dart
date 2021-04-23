import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';

import '../../main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
 Author: Kyle Serruys
 Co-Author:  Sawyer Kisha

 The page allows the signed in user to select a Cadet or a Cadre to perform an evaluation.
 */

class SingleUserToEvaluate extends StatefulWidget {
  @override
  SingleUserToEvaluateState createState() => SingleUserToEvaluateState();
}

class SingleUserToEvaluateState extends State<SingleUserToEvaluate> {
  var userList = <String>[];
  var filteredUserList = <String>[];
  var selectedUserList = <String>[];
  var pagedUserList = <String>[];

  TextEditingController userSearch = TextEditingController();
  ScrollController scrollController;

  List<ElevatedButton> userButtonList = <ElevatedButton>[];
  String firstName = "";
  String lastName = "";
  int namesPerPage = 12;
  int page = 1;
  int bottomOutOfRange = 0;

  bool loading = false;


  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    super.initState();
    getCadetNames();
    getPagedUsersV2();
  }

  /*
 Author: Kyle Serruys
 This puts first name and last name into shared preferences.
 */
  getCadetNames() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstName = prefs.getString("firstName");
      lastName = prefs.getString("lastName");
    });
  }

/*
Author:  Kyle Serruys
This is the function used to take a snapshot of our collection and import the
first and last name of the users in the users collection.
  */
  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await FirebaseFirestore.instance
        .collection('users')
        .orderBy("firstName")
        .get()
        .then((docSnapshot) {
      docSnapshot.docs.forEach((element) {
        userList.add(element.data()['firstName'].toString() +
            " " +
            element.data()['lastName'].toString());
      });
      getPagedUsers();
    });
    setState(() {
      searchList("");
    });
  }

  /*
 Author: Kyle Serruys
 This method takes users and adds them to pages for our pagination.  In other words,
 everytime the user scrolls up, a new page gets made and shows new names.
 */
  getPagedUsers() {
    var newUsers =
        userList.skip((page - 1) * namesPerPage).take(namesPerPage).toList();
    if (newUsers.length > 0) {
      pagedUserList.addAll(newUsers);
      page = page + 1;
    }
    loading = false;
  }
/*
 Author: Kyle Serruys
 This method orders the users on the page by their first name.
 It also sets up skipping the previous pages names.
 */
  getPagedUsersV2() async {
    if (page == 1) {
      var data = await FirebaseFirestore.instance
          .collection('users')
          .orderBy("firstName")
          .limit(namesPerPage)
          .get()
          .then((docSnapshot) {
        docSnapshot.docs.forEach((element) {
          pagedUserList.add(element.data()['firstName'].toString() +
              " " +
              element.data()['lastName'].toString());
        });
      });
    } else {
      var skipThese = await FirebaseFirestore.instance
          .collection('users')
          .orderBy("firstName")
          .limit((page - 1) * namesPerPage)
          .get()
          .then((documentSnapshots) async {
        var startAfterThis =
            documentSnapshots.docs[documentSnapshots.docs.length - 1];

        var nextPage = await FirebaseFirestore.instance
            .collection('users')
            .orderBy("firstName")
            .startAfterDocument(startAfterThis)
            .limit(namesPerPage)
            .get()
            .then((docSnapshot) {
          docSnapshot.docs.forEach((element) {
            pagedUserList.add(element.data()['firstName'].toString() +
                " " +
                element.data()['lastName'].toString());
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
  This list takes the users from our users collection and adds a button with
  their name on it.  This will populate for each and every user in the users
  collection.
  Co-Author: Sawyer Kisha
  Formatted the list of cadets for the interface

  */
  List<Widget> makeButtonsList() {
    userButtonList.clear();
    for (int i = 0; i < filteredUserList.length; i++) {
      userButtonList.add(
        new ElevatedButton(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            selectedUserList.add(filteredUserList[i]);
            prefs.setStringList('selectedUserList', selectedUserList);
            navigation.currentState
                .pushNamed('/individualEvalConfirmationPage');
          },
          child: Container(
              width: 200,
              height: 40,
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[Text(filteredUserList[i])])),
        ),
      );
    }
    return userButtonList;
  }
/*
 Author: Kyle Serruys
 This method creates a circular progress indicator to show while the next page of users
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
 This method let's the signed in user search through the list of cadets or cadres
 depending on what they type in, it adds that value to a new list that is filtered.
 This shows only the users in the list whose value equals the letters typed in the searc
 box.
 */
  searchList(String value) {
    var filter = userSearch.value.text;
    setState(() {
      if (filter == "" || filter == null) {
        filteredUserList = pagedUserList;
      } else {
        filteredUserList = pagedUserList
            .where((element) =>
                element.toLowerCase().contains(filter.toLowerCase()))
            .toList();
      }
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
              getPagedUsersV2();
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
          onPressed: () {
            navigation.currentState.pushNamed('/homePage');
          },
        ),
        title: Text('Evaluation Request'),
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
                    padding: const EdgeInsets.only(top: 80.0, bottom: 20.0),
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        'Select Person to Evaluate:',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    )),
                TextField(
                  controller: userSearch,
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
                ])),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                ),
              ]),
        ),
      ),
    );
  }
}
