import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';

/*
 Author: Sawyer Kisha
 Co-author: Kyle Serruys
  This page is to select the multiple users to evaluate a cadet/cadre.
 */

class MultipleUsersToEvaluate extends StatefulWidget {
  MultipleUsersToEvaluate() : super();

  @override
  MultipleUsersToEvaluateState createState() => MultipleUsersToEvaluateState();
}

class MultipleUsersToEvaluateState extends State<MultipleUsersToEvaluate> {
  var userList = <String>[];
  var usersToEvaluate = <String>[];
  var selectUsersList = <String>[];
  var filteredUserList = <String>[];
  //var tempList = new List<String>();
  var usersSelected = new Map<String, bool>();
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
    getPagedUsersV2();
  }

  bool isSelected(String userName) {
    return usersSelected[userName];
  }

  void toggleUser(String userName) {
    var selectedValue = usersSelected[userName];
    usersSelected[userName] = !selectedValue;
  }

  /*
 Author: Kyle Serruys
 This method orders the users on the page by their first name.
 It also sets up skipping the previous pages names.
 */
  getPagedUsersV2() async {
    if (page == 1) {
/*      var data = */ await FirebaseFirestore.instance
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
/*      var skipThese = */ await FirebaseFirestore.instance
          .collection('users')
          .orderBy("firstName")
          .limit((page - 1) * namesPerPage)
          .get()
          .then((documentSnapshots) async {
        var startAfterThis =
        documentSnapshots.docs[documentSnapshots.docs.length - 1];

/*        var nextPage = */ await FirebaseFirestore.instance
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
      for (int i = 0; i < pagedUserList.length; i++) {
        if (!usersSelected.containsKey(pagedUserList[i].toString())) {
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
  Co-Author: Sawyer Kisha
  Formatted the list of cadets for the interface

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
          style: ElevatedButton.styleFrom(
              side: BorderSide(
                  width: usersSelected[filteredUserList[i]] ? 5.0 : 1.0,
                  color: usersSelected[filteredUserList[i]]
                      ? Colors.amber
                      : Colors.black87)),
          child: Container(
              width: 200,
              height: 40,
              child: new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(filteredUserList[i]),
                  ])),
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
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('selectedUserList');
            navigation.currentState.pushNamed('/homePage');
          },
        ),
        title: Text('Evaluatee Request'),
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
                  padding: const EdgeInsets.only(top: 50.0, bottom: 50.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Select at Least One User to Be Evaluated:',
                      style: TextStyle(
                        fontSize: 18.0,
                      ),
                    ),
                  ),
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
              child: Text('Next'),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                usersSelected.forEach((key, value) {
                  if (value) {
                    usersToEvaluate.add(key);
                  }
                });

                prefs.setStringList('usersToEvaluate', usersToEvaluate);
                if(usersToEvaluate.isEmpty){
                  alertDialog(context);
                }else {
                  navigation.currentState
                      .pushNamed('/multipleEvalConfirmationPage');
                }
              },
            ),
          ],
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
    content: Text("You Must Select at Least One Cadet or Cadre to Evaluate."),
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