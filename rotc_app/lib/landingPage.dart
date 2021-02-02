import 'package:flutter/material.dart';
import 'registrationPage.dart';
import 'signInPage.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('M-Connect'),
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
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => SignInPage()
                        )
                    );
                  },
                ),
              ),
              Container(
                child: ElevatedButton(
                  child: Text('Register'),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => RegistrationPage()
                        )
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}


