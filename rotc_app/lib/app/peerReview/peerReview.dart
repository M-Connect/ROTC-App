import 'package:flutter/material.dart';
import 'package:rotc_app/app/peerReview/peerReviewLanding.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import '../../main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
 Author: Sawyer Kisha
 Co-author: Kyle Serruys
  This class is the home page for our peer review request page
  Needs functionality
 */

class PeerReview extends StatefulWidget {
  @override
  PeerReviewState createState() => PeerReviewState();

}

//Setting how many togglebuttons may be selected
List<bool> isSelected = List.generate(4, (index) => false);

class PeerReviewState extends State<PeerReview> {
  String firstName = "";
  String lastName = "";

  CollectionReference cadets = FirebaseFirestore.instance.collection('cadets');


  Future<void> peerReview(){
    return cadets.add({
      "firstName": firstName,
      "lastName": lastName,
    });
  }

  @override
  void initState(){
    getCadetNames();
  }

  getCadetNames() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState((){
      firstName = prefs.getString("firstName");
      lastName = prefs.getString("lastName");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Evaluation Selection'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.logout),
              onPressed: () {
                alertSignOut(context);
              }
          ),
        ],
      ),

      body: SingleChildScrollView(
          padding: EdgeInsets.all(25.0),
          child: Container(
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:[
                    Padding(

                      padding: const EdgeInsets.only(top: 50.0, bottom: 70.0),
                      child: Text('Select a Cadet:'),

                    ),
                    Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              ToggleButtons(
                                children:<Widget>[
                                  Container(width: (MediaQuery.of(context).size.width - 72)/4, child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[new SizedBox(width: 4.0,), new Text("c t",)],)),
                                  Container(width: (MediaQuery.of(context).size.width - 72)/4, child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[new SizedBox(width: 4.0,), new Text("Sawyer K",)],)),
                                  Container(width: (MediaQuery.of(context).size.width - 72)/4, child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[new SizedBox(width: 4.0,), new Text("mac creed",)],)),
                                  Container(width: (MediaQuery.of(context).size.width - 72)/4, child: new Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[new SizedBox(width: 4.0,), new Text("Test man",)],)),
                                ],
                                isSelected: isSelected,
                                  onPressed: (int index) {
                                    setState(() {
                                      for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                                        if (buttonIndex == index) {
                                          isSelected[buttonIndex] = true;
                                        } else {
                                          isSelected[buttonIndex] = false;
                                        }
                                      }
                                    });
                                  },
                                //isSelected: isSelected,
                              ),
                            ]
                        )
                      // child: Text(firstName ??),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    ),

                  ]
              )
          )
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
                  navigation.currentState.pushNamed('/peerReviewLLAB2FT');
                },
              ),
            ],
          )),
    );
  }
}
