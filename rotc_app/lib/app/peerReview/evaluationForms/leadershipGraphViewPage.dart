import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';

class LeadershipGraphViewPage extends StatefulWidget {
  @override
  _LeadershipGraphViewPageState createState() => _LeadershipGraphViewPageState();
}

class _LeadershipGraphViewPageState extends State<LeadershipGraphViewPage> {
  TextEditingController leadership;

  double leadershipValue;
  var leadershipNotes = "";
  var leadershipScore;

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
      var leadershipValue = prefs.getString("leadership");
      leadership = TextEditingController(text: leadershipValue);
    });
  }

  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var leadershipSliderValue =
          prefs.getString('leadershipValue') ?? 10;
      leadershipValue = double.parse(leadershipSliderValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
automaticallyImplyLeading: false,
        title: Text('Leadership'),
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
                            leadershipValue.round().toString(),
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
                        'Leadership Notes:',
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
                  controller: leadership,
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
