import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';

/*
 Author: Kyle Serruys
  This class is the Execution view for after selecting the execution value on the bar graph.
  It loads up just like execution.dart, except their is no slider bar, the slider value is not
  editable, and the evaluation data is not editable.  The only way to leave the page is to press the
  okay button which will take you back to the bar graph.
 */

class ExecutionGraphViewPage extends StatefulWidget {
  @override
  _ExecutionGraphViewPageState createState() => _ExecutionGraphViewPageState();
}

class _ExecutionGraphViewPageState extends State<ExecutionGraphViewPage> {
  TextEditingController execution;

  double executionValue;
  var executionNotes = "";
  var executionScore;

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
      var executionValue = prefs.getString("execution");
      execution = TextEditingController(text: executionValue);
    });
  }

  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var executionSliderValue = prefs.getString('executionValue') ?? 10;
      executionValue = double.parse(executionSliderValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Execution'),
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
                            executionValue.round().toString(),
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
                        'Evaluator Notes:',
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
                  controller: execution,
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
