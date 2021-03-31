import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rotc_app/app/Schedule/Models/gc_event_model.dart';

final CollectionReference collectionReference = FirebaseFirestore.instance.collection('GCEvents');
final DocumentReference documentReference = collectionReference.doc('GCEventData');

class GCEventCRUD {
  Future<void> createGCEvent(GCEventModel event) async {
    DocumentReference dr = documentReference.collection('GCEvents').doc(event.id);

    Map<String, dynamic> eventDetails = event.convertToJSON();

    await dr.set(eventDetails).whenComplete(() {
    }).catchError((e) => print(e));
  }

  Future<void> updateGCEvent(GCEventModel event) async {
    DocumentReference dr = documentReference.collection('GCEvents').doc(event.id);

    Map<String, dynamic> eventDetails = event.convertToJSON();

    await dr.update(eventDetails).whenComplete(() {
    }).catchError((e) => print(e));
  }

  Future<void> deleteGCEvent({@required String id}) async {
    DocumentReference dr = documentReference.collection('GCEvents').doc(id);

    await dr.delete().catchError((e) => print(e));
  }

  Stream<QuerySnapshot> readAllGCEvents() {
    Stream<QuerySnapshot> qs = documentReference.collection('GCEvents').orderBy('start').snapshots();

    return qs;
  }
}