import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';

/*
 Author: Kyle Serruys
  This class is the Debrief page of our peer review
 */
class Debrief extends StatefulWidget {
  Debrief() : super();

  @override
  DebriefState createState() => DebriefState();
}

class DebriefState extends State<Debrief> {
  TextEditingController debrief;

double debriefValue;
String defaultDebriefValue = "10";
  @override
  void initState() {
    super.initState();
    getUserInfo();
    initSliderValue();
    initControllers();
  }

  initControllers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var debriefValue = prefs.getString("debrief");
      debrief = TextEditingController(text: debriefValue);
    });
  }

  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var debriefSliderValue = prefs.getString('debriefValue') ?? defaultDebriefValue;
      debriefValue = double.parse(debriefSliderValue);
    });
  }

  initSliderValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      sliderChange(debriefValue);
    });
  }
  void sliderChange(double test) {
    setState(() {
      if(test != null){
        test = debriefValue;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            navigation.currentState.pushNamed('/peerReviewLLAB2FT');
          },
        ),
        title: Text('Debrief'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
            onPressed: () { alertSignOut(context);},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Center(

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(
                height: 50.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: (Border.all(
                        color: Colors.black87,
                      )),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(debriefValue.round().toString(),style: TextStyle(fontSize: 25.0, ),),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text('0',style: TextStyle(fontSize: 25.0, ),),
                      flex: 2,
                    ),
                    Expanded(
                      child: Slider(
                        value: debriefValue,
                        onChanged: (newSliderValue) {
                          setState(() => debriefValue = newSliderValue);
                        },
                        min: 0,
                        max: 20,
                      ),
                      flex: 19,
                    ),
                    Expanded(
                      child: Text("20",style: TextStyle(fontSize: 25.0, ),),
                      flex:2,
                    ),
                  ],
                ),
              ),


              SizedBox(
                height: 20.0,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                      child: Text('Evaluator Notes:',style: TextStyle(fontSize: 25.0, ),),
                    ),
                  ],
                ),
              ),
              Container(
                width: 200.0,
                child: TextFormField(
                  textAlignVertical: TextAlignVertical.top,
                  maxLength: 160,
                  maxLengthEnforced: true,
                  maxLines: 10,
                  controller: debrief,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding:
                        // const EdgeInsets.symmetric(vertical: 75.0),

                        EdgeInsets.all(10.0),
                  ),
                  onSaved: (String value) {},
                  validator: RequiredValidator(
                      errorText: "Chain of Command is required"),
                ),
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text("Hint:\n-Adheres to Debrief Format\n-Receptive to Feedback\n-Improvement Oriented\n",style: TextStyle(fontSize: 18.0, ),),
                      flex:8,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      child: Text('Prev'),
                      onPressed: () async {
                        SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        prefs.setString('debrief', debrief.text);
                        prefs.setString('debriefValue', debriefValue.round().toString());
                        navigation.currentState.pushNamed('/leadership');
                      },
                    ),

                    ElevatedButton(
                      child: Text('Confirm'),
                      onPressed: () async {
                        SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                        prefs.setString('debrief', debrief.text);
                        prefs.setString('debriefValue', debriefValue.round().toString());
                        navigation.currentState.pushNamed('/confirmation');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

