import 'package:flutter/material.dart';
import 'package:googleapis/calendar/v3.dart';

/*
Author: Christine Thomas
This class defines the information needed to work with the
Google Calendar API to insert/update/delete events of an accessed account's Google Calendar.
 */
class GCEventOps {

  // This allows operations to be done on  the CalendarAPI object
  // by holding the CalendarAPI object in this variable
  static var schedule;

  /*
  This function inserts a new event into the Google Calendar
  and takes the parameters title, details, location, all of type String,
  userEmails of type List<EventAttendee>, shouldNotifyAttendees of type bool,
  startTime and endTime of time DateTime. This functiom returns a Future
  of type <Map<String, String>> and has an asynchronous body that includes
  a ....................

   */
  Future<Map<String, String>> insert({
    @required String title,
    @required String details,
    @required String location,
    List<EventAttendee> userEmails,
    @required bool shouldNotifyAttendees,
    @required DateTime startTime,
    @required DateTime endTime,
  }) async {

    Map<String, String> eventData;

    String calendarId = "primary";

    // An Event object called event is declared to access  and set the
    // necessary GoogleCalendarAPI properties
    Event event = Event();

    // Setting the summary, title, attendees, and location of the Google Calendar Event
    // to their GCEventOps equivalents that the user will enter in.
    event.summary = title;
    event.description = details;
    event.attendees = userEmails;
    event.location = location;

    // An EventDateTime object called start is declared to access and set the
    // start time of the Google Calendar Event.
    EventDateTime start = new EventDateTime();

    //Setting the dateTime to the GCEventOps equivalent startTime the user will
    // input a date into, setting the timeZone of the app to be that of the intended audience
    // and setting the event start to the start of type EventDateTime defined above.
    start.dateTime = startTime;
    start.timeZone = "GMT-04:00";
    event.start = start;

    // Another EventDateTime object called end is declared to access and set the
    // end time of the Google Calendar Event.
    EventDateTime end = new EventDateTime();

    //Setting the dateTime to the GCEventOps equivalent endTime the user will
    // input a date into, setting the timeZone of the app to be that of the intended audience
    // and setting the event end to the end of type EventDateTime defined above.
    end.timeZone = "GMT-04:00";
    end.dateTime = endTime;
    event.end = end;

    /*
    This will try to insert to the Google Calendar and takes the event object,
    the calendarId which is primary, and sendUpdates which checks if shouldNotifyAttendees
    is true, then updates will be sent to all relevant users otherwise if shouldNotifyAttendees
    is false, then no updates will be sent. Then it checks if the gcEvent status is
    confirmed, if so the eventId is set to the gcEvent's id property and the eventData
    declared at the top of the class will set the 'id' collection field to the eventId.
    If inserting is successful a message will display in the terminal that confirms this
    otherwise an error message will display if unable to add event to Google Calendar.

    Parameters: event, calendarId, sendUpdates
    Returns: eventData
     */
    try {
      await schedule.events
          .insert(event, calendarId,
          sendUpdates: shouldNotifyAttendees ? "all" : "none")
          .then((gcEvent) {
        print("Event Status: ${gcEvent.status}");
        if (gcEvent.status == "confirmed") {
          String eventId;
          eventId = gcEvent.id;
          eventData = {'id': eventId};

          print('Event added to Google Calendar');
        } else {
          print("Unable to add event to Google Calendar");
        }
      });
    } catch (e) {
      print('Creation failed, Error code: $e');
    }

    return eventData;
  }

  /*
  This function updates an event in the Google Calendar
  and takes the parameters title, details, location, all of type String,
  userEmails of type List<EventAttendee>, shouldNotifyAttendees of type bool,
  startTime and endTime of time DateTime. This functiom returns a Future
  of type <Map<String, String>> and has an asynchronous body that includes
  a ....................
   */
  Future<Map<String, String>> update({
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

    // An Event object called event is declared to access  and set the
    // necessary GoogleCalendarAPI properties
    Event event = Event();

    // Setting the summary, title, attendees, and location of the Google Calendar Event
    // to their GCEventOps equivalents that the user will enter in.
    event.summary = title;
    event.description = details;
    event.attendees = userEmails;
    event.location = location;

    // An EventDateTime object called start is declared to access and set the
    // start time of the Google Calendar Event.
    EventDateTime start = new EventDateTime();

    //Setting the dateTime to the GCEventOps equivalent startTime the user will
    // input a date into, setting the timeZone of the app to be that of the intended audience
    // and setting the event start to the start of type EventDateTime defined above.
    start.dateTime = startTime;
    start.timeZone = "GMT-04:00";
    event.start = start;

    // Another EventDateTime object called end is declared to access and set the
    // end time of the Google Calendar Event.
    EventDateTime end = new EventDateTime();

    //Setting the dateTime to the GCEventOps equivalent endTime the user will
    // input a date into, setting the timeZone of the app to be that of the intended audience
    // and setting the event end to the end of type EventDateTime defined above.
    end.dateTime = endTime;
    end.timeZone = "GMT-04:00";
    event.end = end;


    /*
    This will try to patch(update) a  Google Calendar event and takes as parameters:
    the event object, the calendarId which is primary, the id of the event to be updated,
    sendUpdates which checks if shouldNotifyAttendees is true, then updates will be sent to all
    relevant users otherwise if shouldNotifyAttendees is false, then no updates will be sent.
    Then it checks if the gcEvent status is confirmed, if so the eventId is set to the gcEvent's
    id property and the eventData declared at the top of the class will set the 'id' database
    collection field to the eventId. If inserting is successful a message will display in
    the terminal that confirms this otherwise an error message will display if unable to add
    event to Google Calendar.

    Parameters: event, calendarId, id, sendUpdates
    Returns: eventData
     */
    try {
      await schedule.events
          .patch(event, calendarId, id,
          sendUpdates: shouldNotifyAttendees ? "all" : "none")
          .then((gcEvent) {
        print("Event Status: ${gcEvent.status}");
        if (gcEvent.status == "confirmed") {
          String eventId;

          eventId = gcEvent.id;

          eventData = {'id': eventId};

          print('Event updated in Google Calendar');
        } else {
          print("Unable to update event in Google Calendar");
        }
      });
    } catch (e) {
      print('\nUpdate failed, error code: $e');
    }

    return eventData;
  }
/*
This function deletes a Google Calendar event and takes the parameters
eventId of type String and shouldNotifyUsers of type bool. This function returns
a type of Future<void>
 */
  Future<void> delete(String eventId, bool shouldNotifyUsers) async {
    String calendarId = "primary";

    try {
      await schedule.events.delete(calendarId, eventId, sendUpdates: shouldNotifyUsers ? "all" : "none").then((value) {
        print('Event deleted from Google Calendar');
      });
    } catch (e) {
      print('Error occurred while trying to delete. \nDeletion failed, error code: $e');
    }
  }
}