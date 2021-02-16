import 'package:flutter/material.dart';

class ConfirmEmailView extends StatelessWidget {
  final String message;

  const ConfirmEmailView({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        child: Center(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            message,
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        )),
      ),
    );
  }
}
