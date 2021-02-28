import 'package:flutter/material.dart';
import 'package:rotc_app/app/peerReview/peerReviewLanding.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';

/*
 Author: Sawyer Kisha
 Co-author: Kyle Serruys
  This class is the home page for our peer review request page
  Needs functionality
 */
class PeerReviewRequest extends StatelessWidget {
  @override
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
            children: [
              //Selecting a Cadet
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom:10.0),
                child: Text('Cadet Name:'),
              ),
              Container(
                child: Column(
                  children: <Widget> [
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
                ],
                ),
              ),

              SizedBox(
                width: 900,
               child: Row(
                 children: <Widget>[
                 Radio(value: 100, activeColor: Colors.black87, groupValue: null, onChanged: null),
                 Text('AS100'),
                 Radio(value: 200, activeColor: Colors.black87, groupValue: null, onChanged: null),
                 Text('AS200'),
                 Radio(value: 300, activeColor: Colors.black87, groupValue: null, onChanged: null),
                 Text('AS300'),
                 Radio(value: 400, activeColor: Colors.black87, groupValue: null, onChanged: null),
                 Text('AS400'),

                 ],
               ),
              ),
              SizedBox(
                width: 900,
                child: Row(
                  children: <Widget>[
                    Radio(value: 700, activeColor: Colors.black87, groupValue: null, onChanged: null),
                    Text('AS700'),
                    Radio(value: 800, activeColor: Colors.black87, groupValue: null, onChanged: null),
                    Text('AS800'),
                  ],
                ),
              ),
              SizedBox(
                width: 900,
                child: Row(
                  children: <Widget>[
                    Radio(value: 0, activeColor: Colors.black87, groupValue: null, onChanged: null), //test value
                    Text('GMC'),
                    Radio(value: 1, activeColor: Colors.black87, groupValue: null, onChanged: null), //test value
                    Text('POC'),
                  ],
                ),
              ),
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
                width: 400.0,
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.top,
                  maxLength: 160,
                  maxLengthEnforced: true,
                  maxLines: 10,
                  //controller:
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding: EdgeInsets.all(10.0),
                    // const EdgeInsets.symmetric(vertical: 75.0),
                  ),
                  onSaved: (String value) {},
                ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
          padding:
          EdgeInsets.only(bottom: 20.0, left: 10.0, top: 20.0, right: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                child: Text('Submit'),
                onPressed: () async {},
              ),
            ],
          )),
    );
  }
}
