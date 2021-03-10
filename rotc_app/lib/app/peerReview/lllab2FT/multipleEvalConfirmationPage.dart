import 'package:flutter/material.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';

class MultipleEvalConfirmationPage extends StatefulWidget {
  @override
  _MultipleEvalConfirmationPageState createState() => _MultipleEvalConfirmationPageState();
}

class _MultipleEvalConfirmationPageState extends State<MultipleEvalConfirmationPage> {
  var usersToEvaluate = new List<String>();
  String userDisplayString;

  @override
  void initState() {
    super.initState();
    getSelectedUser();
  }

  getSelectedUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {

      userDisplayString = prefs.getStringList("usersToEvaluate").join(", ");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request'),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.logout),
              onPressed: () {
                alertSignOut(context);
              }),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                height: 75,
                padding: (EdgeInsets.all(5.0)),
                decoration: BoxDecoration(
                  border: (Border.all(color: Colors.black87)),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        child: Text('$userDisplayString to be under evaluation',
                          style: TextStyle(
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Text("Evaluation Date: ",
                        style: TextStyle(
                          fontSize: 17.5,
                      ),
                      ),
                    ),
                    Container(
                      child: Text("Date",
                        style: TextStyle(
                        fontSize: 17.5,
                      ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Text('Evaluation Activity: ',
                        style: TextStyle(
                        fontSize: 17.5,
                      ),
                      ),
                    ),
                    Container(
                      child: Text('Activities',
                        style: TextStyle(
                        fontSize: 17.5,
                      ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
              ),
              Container(
                width: 200,
                height: 40,
                child: ElevatedButton(
                  child: Text('Next'),
                  onPressed: () {
                    navigation.currentState.pushNamed('/usersToDoEvaluation');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
