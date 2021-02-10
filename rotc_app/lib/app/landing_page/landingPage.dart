import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Landing Page'),
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
                  child: Text('Cadet Home Page'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/cadetHome'
                    );
                  },
                ),
              ),
              Container(
                child: ElevatedButton(
                  child: Text('Cadre Home Page'),
                  onPressed: () {
                    Navigator.pushNamed(context, '/cadreHome'
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
