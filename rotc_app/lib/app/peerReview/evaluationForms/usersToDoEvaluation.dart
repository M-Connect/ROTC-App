import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';

/*
  Author:  Kyle Serruys
  This page allows the signed in user to select who will be performing the evaluation.
  Co-Author: Christine Thomas
  added the isCadre check to change the appBar Color depending on which
  type of user is signed in.
 */
class UsersToDoEvaluation extends StatefulWidget {
  @override
  _UsersToDoEvaluationState createState() => _UsersToDoEvaluationState();
}

class _UsersToDoEvaluationState extends State<UsersToDoEvaluation> {
  var userList = new List<String>();
  var usersToEvaluate = new List<String>();
  var usersToDoEvaluation = new List<String>();
  var selectUsersList = new List<String>();
  var filteredUserList = new List<String>();
  var tempList = new List<String>();
  var usersSelected = new Map<String,bool>();
  var selectedActivityList = new List<String>();
  var pagedUserList = new List<String>();
  String selectedActivityString;
  String evalDate = "";

  bool isCadre = false;
  bool loading = false;


  TextEditingController userSearch = TextEditingController();
  ScrollController scrollController;

  List<ElevatedButton> userButtonList = new List<ElevatedButton>();
  String firstName = "";
  String lastName = "";

  int namesPerPage = 12;
  int page = 1;
  int bottomOutOfRange = 0;

  CollectionReference evaluationRequests = FirebaseFirestore.instance.collection('userEvaluationRequests');
/*
  Author:  Kyle Serruys
  This adds the appropriate information to our userEvaluationRequests database.
  */
  Future<void> userEvaluationRequests() {
    var selectedUsers = new List<String>();
    usersSelected.entries.forEach((entry) {
      if(entry.value) {
        selectedUsers.add(entry.key);
      }
    });

    selectedUsers.forEach((evaluator) {
      usersToEvaluate.forEach((evaluatee) {
        return evaluationRequests.add({
          "evaluator": evaluator,
          "evaluatee":evaluatee,
          "activity":selectedActivityString,
          "evaluationDate":evalDate,
          "status":"Pending"
        });
      });
    });
  }


  @override
  void initState() {
    scrollController = ScrollController();
    scrollController.addListener(_scrollListener);
    super.initState();
   // getUserInfo();
    getUsersToEvaluate();
    getSelectedActivity();
    getEvaluationDate();
    getBool();
    getPagedUsersV2();
  }
/*
  Author:  Kyle Serruys
  This gets the activity from shared preferences and sets it to a string.
  */

  getSelectedActivity() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedActivityList = prefs.getStringList("selectedActivityList".toString());
      selectedActivityString = prefs.getStringList("selectedActivityList").reduce((value, element) => value + element);
    });
  }
/*
  Author:  Kyle Serruys
  This gets the date from shared preferences
  */

  getEvaluationDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      evalDate = prefs.getString('evaluationDate') ?? " ";
      var formattedEvalDate = evalDate.substring(0,10);
      evalDate = formattedEvalDate;
    });
  }

  /*
  Author:  Kyle Serruys
  This gets the users to evaluate from shared preferences
  */

  getUsersToEvaluate() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    usersToEvaluate = prefs.getStringList("usersToEvaluate");
  }

  /*
  Author:  Kyle Serruys
  This takes the users from our users collection and stores them in a list to be used later.
  *//*

  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await FirebaseFirestore.instance
        .collection('users').orderBy("firstName")
        .get()
        .then((docSnapshot) {
      docSnapshot.docs.forEach((element) {
        userList.add(element.data()['firstName'].toString() + " " +
            element.data()['lastName'].toString());
      });
      getPagedUsers();
    });
    setState(() {
      for(int i = 0; i <  userList.length; i++) {
        if(!usersSelected.containsKey(userList[i].toString())) {
          usersSelected[userList[i].toString()] = false;
        }
      }
      searchList("");
    });
  }
*/
  /*
  Author:  Kyle Serruys
  returns the userName of a selected user
  */

  bool isSelected(String userName) {
    return usersSelected[userName];
  }

  /*
  Author:  Kyle Serruys
  This allows the user to be a selected value
  */

  void toggleUser(String userName)
  {
    var selectedValue =  usersSelected[userName];
    usersSelected[userName] = !selectedValue;
  }

/*  *//*
 Author: Kyle Serruys
 This method takes users and adds them to pages for our pagination.  In other words,
 everytime the user scrolls up, a new page gets made and shows new names.
 *//*
  getPagedUsers() {
    var newUsers =
    userList.skip((page - 1) * namesPerPage).take(namesPerPage).toList();
    if (newUsers.length > 0) {
      pagedUserList.addAll(newUsers);
      page = page + 1;
    }
    loading = false;
  }*/
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
      for(int i = 0; i <  pagedUserList.length; i++) {
        if(!usersSelected.containsKey(pagedUserList[i].toString())) {
          usersSelected[pagedUserList[i].toString()] = false;
        }
      }
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
    userButtonList.clear();
    for (int i = 0; i < filteredUserList.length; i++) {
      userButtonList.add(
        new ElevatedButton(
          onPressed: () async {
            setState(() {
              toggleUser(filteredUserList[i]);
            });
          },
          style: ElevatedButton.styleFrom(side : BorderSide(width: usersSelected[filteredUserList[i]] ? 5.0 : 1.0,
              color: usersSelected[filteredUserList[i]] ?Colors.amber : Colors.black87)),
          child: Container(
              width: 200,
              height: 40,
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:<Widget>[
                    Text(filteredUserList[i]),
                  ]
              )
          ),
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
      if(filter == "" || filter == null)
      {
        filteredUserList = pagedUserList;
      }
      else{
        filteredUserList = pagedUserList
            .where(
                (element) => element.toLowerCase().contains(filter.toLowerCase()))
            .toList();
      }
    });
  }
  getBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isCadre = prefs.getString('isCadre') == 'true';
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
        backgroundColor: isCadre ? Color(0xFF031f72) : Colors.blue,
        title: Text('Request Evaluator'),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 50.0),
                    child: Container(
                      child: Text('Select at Least One User to Perform Evaluation:',
                        style: TextStyle(
                          fontSize: 18.0,
                        ),
                       ),
                     )
                  ),
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
      bottomNavigationBar: Padding(
        padding:
        EdgeInsets.only(bottom: 40.0, left: 10.0, top: 40.0, right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text('Submit'),
              onPressed: () async {
                SharedPreferences prefs= await SharedPreferences.getInstance();
                usersSelected.forEach((key, value) {
                  if (value) {
                    usersToDoEvaluation.add(key);
                  }
                });
                await userEvaluationRequests();
                prefs.remove("usersToEvaluate");
                prefs.remove('evaluationDate');
                prefs.remove('selectedActivityList');
                if(usersToDoEvaluation.isEmpty){
                  alertDialog(context);
                }else {
                  navigation.currentState
                      .pushNamed('/homePage');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

Future <void> alertDialog(BuildContext context) {
  Widget button = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text("You Must Select at Least One Cadet or Cadre to Perform an Evaluation."),
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