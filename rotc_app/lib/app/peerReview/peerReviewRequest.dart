import 'package:flutter/material.dart';
import 'package:rotc_app/app/peerReview/peerReviewLanding.dart';

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
            onPressed: (){},

          ),
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
      );
  }
}
