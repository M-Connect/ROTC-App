import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rotc_app/app/peerReview/peerReviewLanding.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../main.dart';

/*
 Author: Sawyer Kisha
 Co-author: Kyle Serruys
  This class is the home page for our peer review request page
  Needs functionality
 */

class PeerReviewRequest extends StatefulWidget {
  @override
  PeerReviewRequestState createState() => PeerReviewRequestState();

}

//Setting how many togglebuttons may be selected
List<bool> isSelected = List.generate(4, (index) => false);

class PeerReviewRequestState extends State<PeerReviewRequest> {
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
        title: Text('Peer Review Request'),
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
                child: Text('Select Cadet(s):'),

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
                          onPressed: (int index){
                            setState((){
                              isSelected[index] = !isSelected[index];
                            });
                          },
                          borderWidth: 3,
                          borderColor: Colors.lightBlue,
                          hoverColor: Colors.grey,
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
                child: Text('Submit'),
                onPressed: () async {
                  navigation.currentState.pushNamed('/homePage');
                },
              ),
            ],
          )),
      );
  }
}


/*
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Form(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Selecting a Cadet
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom:10.0),
                child: Text('Cadet Name:'),
              ),
              Container(
                width: 200.0, //Box length
                child: new DropdownButton<String>(
                  underline: Container(
                    height: 2,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                    ),
                  ),
                  hint: Text('Select a Cadet'),
                  //Temporary placements (will fix with actual users in future)
                items: <String>['John', 'James', 'Jones', 'Jackson'].map((String value) {
                  return new DropdownMenuItem<String>(
                    value: value,
                    child: new Text(value),
                  );
                }).toList(),
                onChanged: (_) {},
              ),
              ),
              //Radio buttons 100 - 400 (Two rows)
              ButtonBar(
                alignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Radio(value: 100, activeColor: Colors.black87, groupValue: null, onChanged: null),
                  Text('100'),
                  Radio(value: 200, activeColor: Colors.black87, groupValue: null, onChanged: null),
                  Text('200'),
                  Radio(value: 300, activeColor: Colors.black87, groupValue: null, onChanged: null),
                  Text('300'),
                  Radio(value: 400, activeColor: Colors.black87, groupValue: null, onChanged: null),
                  Text('400'),
                ],
              ),

              //Radio buttons 500 - 800 (Two rows)
              ButtonBar(
                  alignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                  Radio(value: 700, activeColor: Colors.black87, groupValue: null, onChanged: null),
                  Text('700'),
                  Radio(value: 800, activeColor: Colors.black87, groupValue: null, onChanged: null),
                  Text('800'),
                 ],
              ),

              //Radio buttons GMC and POC
              ButtonBar(
                  alignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Radio(value: 0, activeColor: Colors.black87, groupValue: null, onChanged: null), //Temp value set to 0
                    Text('GMC'),
                    Radio(value: 1, activeColor: Colors.black87, groupValue: null, onChanged: null), //Temp calue set to 1
                    Text('POC'),
                  ],
              ),

              //Specify Reviewers
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom:10.0),
                child: Text('Specify Reviewer(s): '),
              ),
              Container(
                width: 200.0, //Box length
                child: new DropdownButton<String>(
                  underline: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                  ),
                  hint: Text('Select reviewer(s)'),
                  //Temporary placements (will fix with actual users in future)
                  items: <String>['John', 'James', 'Jones', 'Jackson'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ),

              //Peer Review for:
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom:10.0),
                child: Text('Evaluation for:'),
              ),
              Container(
                width: 200.0, //Box length
                child: new DropdownButton<String>(
                  underline: Container(
                    height: 2,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                    ),
                  ),
                  hint: Text('Select an event'),
                  //Temporary placements (will fix with actual users in future)
                  items: <String>['Activity', 'Exercise', 'Run', 'Weights'].map((String value) {
                    return new DropdownMenuItem<String>(
                      value: value,
                      child: new Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {},
                ),
              ),
            ],
        ),
      ),
      ),
      */
