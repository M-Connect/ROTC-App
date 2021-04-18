<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';

class PlanningGraphViewPage extends StatefulWidget {
  @override
  _PlanningGraphViewPageState createState() => _PlanningGraphViewPageState();
}

class _PlanningGraphViewPageState extends State<PlanningGraphViewPage> {
  TextEditingController planning;

  double planningValue;
  var planningNotes = "";
  var planningScore;

  @override
  void initState() {
    super.initState();
    initControllers();
    getUserInfo();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    // initSliderValue();
  }

  initControllers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var planningValue = prefs.getString("planning");
      planning = TextEditingController(text: planningValue);
    });
  }

  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var planningSliderValue =
          prefs.getString('planningValue') ?? 10;
      planningValue = double.parse(planningSliderValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
automaticallyImplyLeading: false,
        title: Text('Planning'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
            onPressed: () {
              alertSignOut(context);
            },
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
                          child: Text(
                            planningValue.round().toString(),
                            style: TextStyle(
                              fontSize: 25.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
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
                      child: Text(
                        'Planning Notes:',
                        style: TextStyle(
                          fontSize: 25.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 200.0,
                child: TextFormField(
                  enabled: false,
                  textAlignVertical: TextAlignVertical.top,
                  maxLength: 160,
                  maxLengthEnforced: true,
                  maxLines: 10,
                  controller: planning,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    contentPadding:
                    // const EdgeInsets.symmetric(vertical: 75.0),

                    EdgeInsets.all(10.0),
                  ),
                  onSaved: (String value) {},
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              ElevatedButton(
                child: Text('Okay'),
                onPressed: () {
                  navigation.currentState.pushNamed("/barGraph");


                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

=======
import 'package:flutter/material.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';

/*
Author: Kyle Serruys
   Co-Author: Christine Thomas
  Overall styling and added the isCadre check to change the appBar Color
  depending on which type of user is signed in.
 */
class PlanningGraphViewPage extends StatefulWidget {
  @override
  _PlanningGraphViewPageState createState() => _PlanningGraphViewPageState();
}

class _PlanningGraphViewPageState extends State<PlanningGraphViewPage> {
  TextEditingController planning;

  double planningValue;
  var planningNotes = "";
  var planningScore;
  bool isCadre = false;

  @override
  void initState() {
    super.initState();
    initControllers();
    getUserInfo();
    getBool();
    // initSliderValue();
  }

  initControllers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var planningValue = prefs.getString("planning");
      planning = TextEditingController(text: planningValue);
    });
  }

  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var planningSliderValue =
          prefs.getString('planningValue') ?? 10;
      planningValue = double.parse(planningSliderValue);
    });
  }
  getBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isCadre = prefs.getString('isCadre') == 'true';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: isCadre ? Color(0xFF031f72) : Colors.blue,
        automaticallyImplyLeading: false,
        title: Text('Planning'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp),
          onPressed: (){
            navigation.currentState.pushNamed("/barGraph");
          },
        ),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
            onPressed: () {
              alertSignOut(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: 'Planning Score:',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ' +
                              planningValue.round().toString(),
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 30,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20.0,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: 'Notes:',
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: TextFormField(
                        enabled: false,
                        textAlignVertical: TextAlignVertical.top,
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        ),
                        textCapitalization: TextCapitalization.sentences,
                        maxLength: 160,
                        maxLengthEnforced: true,
                        maxLines: 8,
                        controller: planning,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding:
                          // const EdgeInsets.symmetric(vertical: 75.0),

                          EdgeInsets.all(15.0),
                        ),
                        onSaved: (String value) {},
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 50.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
>>>>>>> Christine_WIP03
