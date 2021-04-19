import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';

/*
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
  String selectedActivityString;
  String evalDate = "";
  bool isCadre = false;


  TextEditingController userSearch = TextEditingController();

  List<ElevatedButton> userButtonList = new List<ElevatedButton>();
  String firstName = "";
  String lastName = "";

  CollectionReference evaluationRequests = FirebaseFirestore.instance.collection('userEvaluationRequests');

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


    /*return evaluationRequests.add({
      "usersToEvaluate": usersToEvaluate,
      "usersToDoEvaluation": selectUsersList,
    });*/
  }

/*
Author:  Kyle Serruys

  */
  @override
  void initState() {
    super.initState();
    getUserInfo();
    getUsersToEvaluate();
    getSelectedActivity();
    getEvaluationDate();
    getBool();
  }

  getSelectedActivity() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedActivityList = prefs.getStringList("selectedActivityList".toString());
      selectedActivityString = prefs.getStringList("selectedActivityList").reduce((value, element) => value + element);
    });
  }


  getEvaluationDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      evalDate = prefs.getString('evaluationDate') ?? " ";
    //  DateTime evaluationDate = new DateFormat("MM-dd-yyyy").parse(evalDate);
    });
  }

  getUsersToEvaluate() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    usersToEvaluate = prefs.getStringList("usersToEvaluate");
  }

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

  bool isSelected(String userName) {
    return usersSelected[userName];
  }

  void toggleUser(String userName)
  {
    var selectedValue =  usersSelected[userName];
    usersSelected[userName] = !selectedValue;
  }

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


  searchList(String value) {
    var filter = userSearch.value.text;
    setState(() {
      if(filter == "" || filter == null)
      {
        filteredUserList = userList;
      }
      else{
        filteredUserList = userList
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
                            prefs.setStringList('selectUsersList', selectUsersList);
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
                await userEvaluationRequests();
                prefs.remove("usersToEvaluate");
                prefs.remove('evaluationDate');
                prefs.remove('selectedActivityList');
                navigation.currentState.pushNamed('/homePage');
              },
            ),
          ],
        ),
      ),
    );
  }
}
