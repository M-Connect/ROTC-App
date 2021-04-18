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
      var planningSliderValue = prefs.getString('planningValue') ?? 10;
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
