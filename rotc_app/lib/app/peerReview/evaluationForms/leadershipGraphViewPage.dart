import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';

/*
Author: Kyle Serruys
  Co-Author: Christine Thomas
  Overall UI styling and added the isCadre check to change the appBar Color
  depending on which type of user is signed in.


 */
class LeadershipGraphViewPage extends StatefulWidget {
  @override
  _LeadershipGraphViewPageState createState() =>
      _LeadershipGraphViewPageState();
}

class _LeadershipGraphViewPageState extends State<LeadershipGraphViewPage> {
  TextEditingController leadership;

  double leadershipValue;
  var leadershipNotes = "";
  var leadershipScore;
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
      var leadershipValue = prefs.getString("leadership");
      leadership = TextEditingController(text: leadershipValue);
    });
  }

  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var leadershipSliderValue = prefs.getString('leadershipValue') ?? 10;
      leadershipValue = double.parse(leadershipSliderValue);
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
        title: Text('Leadership'),
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
                      text: 'Leadership Score:',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: ' ' +
                              leadershipValue.round().toString(),
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
                            controller: leadership,
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
