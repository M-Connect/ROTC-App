import 'package:flutter/material.dart';

/*
Author: Christine Thomas
This class creates the model for the Google Calendar Event Data.

 */
class GCEventModel {
  final String id;
  final String title;
  final String details;
  final String location;
  final List<dynamic> userEmails;
  final bool shouldNotifyUsers;
  final int startTime;
  final int endTime;

  GCEventModel({
    @required this.id,
    @required this.title,
    @required this.details,
    @required this.location,
    @required this.userEmails,
    @required this.shouldNotifyUsers,
    @required this.startTime,
    @required this.endTime,
  });

  /*
  This function takes a snapshot of type Map and
  maps the data fields from the database into a readable format
   */
  GCEventModel.mapData(Map snapshot) :
        id = snapshot['id'] ?? '',
        title = snapshot['title'] ?? '',
        details = snapshot['details'],
        location = snapshot['location'],
        userEmails = snapshot['userEmails'],
        shouldNotifyUsers = snapshot['shouldNotifyUsers'],
        startTime = snapshot['startTime'],
        endTime = snapshot['endTime'];

  /*
  This function returns the converted event field data into JSON
  that can then be uploaded to the database
   */
  convertToJSON() {
    return {
      'id': id,
      'title': title,
      'details': details,
      'location': location,
      'userEmails': userEmails,
      'shouldNotifyUsers': shouldNotifyUsers,
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}
