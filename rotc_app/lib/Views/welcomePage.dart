import 'package:flutter/material.dart';

// Author: Kyle Serruys
// created major button interfaces and initial routing with Material Page Route
// Co-Author: Christine Thomas
// changed routing code to use Routes used in main.dart
// changed by using Navigator.pushName(context, 'route')
class WelcomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('M-Connect'),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.all(25.0),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                child: ElevatedButton(
                  child: Text('Sign In'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/signIn'
                    );
                  },
                ),
              ),
              Container(
                child: ElevatedButton(
                  child: Text('Register'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/register'
                    );
                  },
                ),
              ),
            ],
          ),
        ),
    );
  }
}


