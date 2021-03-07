import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rotc_app/app/peerReview/peerReviewLanding.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
 Author: Sawyer Kisha
 Co-author: Kyle Serruys
  This class is the home page for our peer review request page
  Needs functionality
 */
class PeerReviewRequest extends StatefulWidget {
  PeerReviewRequest() : super();

  @override
  PeerReviewRequestState createState() => PeerReviewRequestState();
}

class PeerReviewRequestState extends State<PeerReviewRequest> {
  var userList = new List<String>();
  List<ElevatedButton> userButtonList = new List<ElevatedButton>();

  @override
  void initState() {
    super.initState();

    getUserInfo();
    //  initSliderValue();
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
    setState(() {});
  }

  List<Widget> makeButtonsList(){
    for (int i = 0; i < userList.length; i++) {
      userButtonList
          .add(new ElevatedButton(onPressed: (){}, child: Text(userList[i])));
    }
    return userButtonList;
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Peer Review request'),
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
