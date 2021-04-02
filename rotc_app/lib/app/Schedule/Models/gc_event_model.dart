import 'package:flutter/material.dart';

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

  GCEventModel.mapData(Map snapshot)
      : id = snapshot['id'] ?? '',
        title = snapshot['name'] ?? '',
        details = snapshot['desc'],
        location = snapshot['loc'],
        userEmails = snapshot['emails'] ?? '',
        shouldNotifyUsers = snapshot['should_notify'],
        startTime = snapshot['start'],
        endTime = snapshot['end'];

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
