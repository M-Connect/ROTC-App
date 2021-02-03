import 'package:flutter/material.dart';
import 'app/registration_page/registrationPage.dart';
import 'app/sign_in/signInPage.dart';

class WelcomePage extends StatelessWidget {
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


