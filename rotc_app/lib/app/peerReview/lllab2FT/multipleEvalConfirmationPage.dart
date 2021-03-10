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
                      child: Text(
                        '$userDisplayString Evaluation',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Text("Evaluation Date:"),
                    ),
                    Container(
                      child: Text("Insert Calendar Here"),
                    ),
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Container(
                      child: Text('Evaluation Activity:'),
                    ),
                    Container(
                      child: Text(
                        'insert activities here',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: ElevatedButton(
                  child: Text('Start Evaluation'),
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
