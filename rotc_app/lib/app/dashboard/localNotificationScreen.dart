import 'package:flutter/material.dart';

import 'notificationPlugin.dart';

class LocalNotificationsScreen extends StatefulWidget {
  @override
  _LocalNotificationsScreenState createState() =>
      _LocalNotificationsScreenState();
}

class _LocalNotificationsScreenState extends State<LocalNotificationsScreen> {
  @override
  void initState(){
    super.initState();
    notificationPlugin.setListenerForLowerVersions(onNotificationsInLowerVersions);
    notificationPlugin.setOnNotificationClick(onNotificationClick);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Local Notifications'),
      ),
      body: Center(
        child: TextButton(
          onPressed: () async {
            await notificationPlugin.showNotification();

          },
          child: Text('Send Notification'),
        ),
      ),
    );
  }
  onNotificationsInLowerVersions (ReceivedNotification receivedNotification){

  }

  onNotificationClick(String payload){
    print('Payload $payload');
  }
}
