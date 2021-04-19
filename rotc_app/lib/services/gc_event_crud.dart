import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rotc_app/app/Schedule/Models/gc_event_model.dart';

/*
Author: Christine Thomas
This class performs CRUD operations on the database collection that holds the Google Calendar Event Data
 */

// Creating a CollectionReference object called collection reference and setting it to an instance
// of the collection 'GCEvents to store event data in a document called 'GCEventData'.
final CollectionReference collectionReference = FirebaseFirestore.instance.collection('GCEvents');

// Creating a DocumentReference object called to documentReference to refer to the aforementioned
// document 'GCEventData'
final DocumentReference documentReference = collectionReference.doc('GCEventData');

class GCEventCRUD {

  /*
  This method has a return type of Future<void> and takes as a parameter an event of type GCEventModel.
  The method will create the event the user enters in the app to the database collection titled
  'GCEvents' in a document with the same name as the event's id.
   */
  Future<void> createGCEvent(GCEventModel event) async {
    DocumentReference dr = documentReference.collection('GCEvents').doc(event.id);

    // converting the event info to JSON before writing to the database
    Map<String, dynamic> eventDetails = event.convertToJSON();

    // populating the document with the event fields as laid out in the GCEventModel and the
    // user entered data that corresponds to it.
    // Once the process is complete this will catch and print any errors.
    await dr.set(eventDetails).whenComplete(() {
    }).catchError((e) => print(e));
  }

  /*
  This method has a return type of Future<void> and takes as a parameter an event of type GCEventModel.
  The method will update the event the user chooses in the app and reflect that within the database
  collection titled 'GCEvents' in a document with the same name as the event's id.
   */
  Future<void> updateGCEvent(GCEventModel event) async {
    DocumentReference dr = documentReference.collection('GCEvents').doc(event.id);

    Map<String, dynamic> eventDetails = event.convertToJSON();

    // populating the document with the event fields as laid out in the GCEventModel and the
    // user entered data that corresponds to it.
    // Once the process is complete this will catch and print any errors.
    await dr.update(eventDetails).whenComplete(() {
    }).catchError((e) => print(e));
  }

  /*
  This method has a return type of Future<void> and takes as a parameter a required id of type String.
  The method will delete the event the user chooses in the app and reflect that within the database
  collection titled 'GCEvents'. This does so by getting the id of the document with the event data to be
  deleted.
   */
  Future<void> deleteGCEvent({@required String id}) async {
    DocumentReference dr = documentReference.collection('GCEvents').doc(id);

    // deleting the document in question and catching and printing any errors that occur.
    await dr.delete().catchError((e) => print(e));
  }

  /*
  This method retrieves all the Google Calendar Events from the database.
   The method therefore returns a Stream of QuerySnapshots, named qs that is a documentReference to
   a collection titled 'GCEvents' and it is ordered by the 'startTime' so the most upcoming event
   will be retrieved first and the farthest event out will be last.
   */
  Stream<QuerySnapshot> readAllGCEvents() {
    Stream<QuerySnapshot> qs = documentReference.collection('GCEvents').orderBy('startTime').snapshots();

    return qs;
  }
}