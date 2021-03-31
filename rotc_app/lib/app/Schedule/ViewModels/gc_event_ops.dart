import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';

class GCEventOps {
  static var schedule;

  Future<Map<String, String>> insert({
    @required String title,
    @required String details,
    @required String location,
    @required List<EventAttendee> userEmails,
    @required bool shouldNotifyAttendees,
    @required DateTime startTime,
    @required DateTime endTime,
  }) async {
    Map<String, String> eventData;

    String calendarId = "primary";
    Event event = Event();

    event.summary = title;
    event.description = details;
    event.attendees = userEmails;
    event.location = location;


    EventDateTime start = new EventDateTime();
    start.dateTime = startTime;
    start.timeZone = "GMT+05:30";
    event.start = start;

    EventDateTime end = new EventDateTime();
    end.timeZone = "GMT+05:30";
    end.dateTime = endTime;
    event.end = end;

    try {
      await schedule.events
          .insert(event, calendarId,
          sendUpdates: shouldNotifyAttendees ? "all" : "none")
          .then((value) {
        print("Event Status: ${value.status}");
        if (value.status == "confirmed") {
          String eventId;
          eventId = value.id;
          eventData = {'id': eventId};

          print('Event added to Google Calendar');
        } else {
          print("Unable to add event to Google Calendar");
        }
      });
    } catch (e) {
      print('Error creating event $e');
    }

    return eventData;
  }

  Future<Map<String, String>> modify({
    @required String id,
    @required String title,
    @required String details,
    @required String location,
    @required List<EventAttendee> userEmails,
    @required bool shouldNotifyAttendees,
    @required DateTime startTime,
    @required DateTime endTime,
  }) async {
    Map<String, String> eventData;

    String calendarId = "primary";
    Event event = Event();

    event.summary = title;
    event.description = details;
    event.attendees = userEmails;
    event.location = location;

    EventDateTime start = new EventDateTime();
    start.dateTime = startTime;
    start.timeZone = "GMT-4";
    event.start = start;

    EventDateTime end = new EventDateTime();
    end.timeZone = "GMT-4";
    end.dateTime = endTime;
    event.end = end;

    try {
      await schedule.events
          .patch(event, calendarId, id,
          sendUpdates: shouldNotifyAttendees ? "all" : "none")
          .then((value) {
        print("Event Status: ${value.status}");
        if (value.status == "confirmed") {
          String eventId;

          eventId = value.id;

          eventData = {'id': eventId};

          print('Event updated in google calendar');
        } else {
          print("Unable to update event in google calendar");
        }
      });
    } catch (e) {
      print('Error updating event $e');
    }

    return eventData;
  }

  Future<void> delete(String eventId, bool shouldNotify) async {
    String calendarId = "primary";

    try {
      await schedule.events.delete(calendarId, eventId, sendUpdates: shouldNotify ? "all" : "none").then((value) {
        print('Event deleted from Google Calendar');
      });
    } catch (e) {
      print('Error deleting event: $e');
    }
  }
}