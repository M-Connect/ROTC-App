import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MultipleReviewRequest extends StatefulWidget {
  @override
  _MultipleReviewRequestState createState() => _MultipleReviewRequestState();
}

class _MultipleReviewRequestState extends State<MultipleReviewRequest> {
  var userList = new List<String>();
  List<ElevatedButton> userButtonList = new List<ElevatedButton>();
  var selectUsersList = new List<String>();
  var filteredUserList = new List<String>();
  var tempList = new List<String>();

  TextEditingController userSearch = TextEditingController();


  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var data = await FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((docSnapshot) {
      docSnapshot.docs.forEach((element) {
        userList.add(element.data()['firstName'].toString() +
            element.data()['lastName'].toString());
      });
    });
    setState(() {
      searchList("");
    });
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


  List<Widget> makeButtonsList(){
    for (int i = 0; i < userList.length; i++) {
      userButtonList
          .add(new ElevatedButton(onPressed: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        selectUsersList.add(userList[i]);
      }, child: Text(userList[i])));
    }
    return userButtonList;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Evalu request'),
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
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children:
            makeButtonsList(),

          ),
        ),
      ),
    );
  }
}