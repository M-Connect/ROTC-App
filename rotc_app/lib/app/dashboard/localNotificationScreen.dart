import 'package:flutter/material.dart';

class LocalNotificationsScreen extends StatefulWidget {
  @override
  _LocalNotificationsScreenState createState() =>
      _LocalNotificationsScreenState();
}

class _LocalNotificationsScreenState extends State<LocalNotificationsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Notifications'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {

          },
          child: Text('Send Notification'),
        ),
      ),
    );
  }
}
