

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


/*
  Author: Christine Thomas
  Description: CRUD Operations on User Profile Data for User Customization.
 */

class Profile extends StatefulWidget {
  Profile({Key key}) : super(key: key);
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  /// adding reference to database for profile collection path use
  CollectionReference profiles = FirebaseFirestore.instance.collection('profiles');
  Map<String, dynamic> biography;
  Map profileData;

  /// TODO: ADD BIO SHOULD BE CALLED UPON REGISTRATION
  /// TO ENSURE ONLY ONE BIO IS CREATED PER USER -CT
  ///
  /// This function gives a user a blank biography upon registration.
  Future<void> createBio() async {

    /// Referencing the cadre collection to get number of documents
    /// to create custom document name for user to be able to update
    /// their own biography.
    CollectionReference cadre = FirebaseFirestore.instance.collection('cadres');
    cadre.snapshots().listen((snapshot){
      List docs;
      docs = snapshot.docs;
      int numberOfDocs = docs.length;
     print('$numberOfDocs');
    });

    /// TODO: add bio via custom doc name and setting fields
    Map<String, dynamic> bioText = {'biography': 'Add a bio'};
    CollectionReference profiles = FirebaseFirestore.instance.collection('profiles');
    profiles.add(bioText);


  }

  readBio(){
    /// make Biography public
    CollectionReference profiles = FirebaseFirestore.instance.collection('profiles');
    profiles.snapshots().listen((snapshot) {

      setState(() {
       // QueryDocumentSnapshot data = snapshot.docs[0];
        profileData = snapshot.docs[0].data();
      });

    });
    //profileCollection['biography'].toString();

  }


  updateBio({Map<String, dynamic> biography}){
    /// update Biography in database
    CollectionReference profiles = FirebaseFirestore.instance.collection('profiles');
    String docId;

    profiles.doc().set({'biography': 'sup homie'})
    .then((value) => print('Profile updated')).catchError((error) => print('Failed to update'));

  }



  /// May need to update Firestore plugin...
  deleteBio() async {
    /// delete Biography from database
    CollectionReference profiles = FirebaseFirestore.instance.collection('profiles');


  }

  readNickname(){
    /// make Nickname public
    /// TODO: add if statement to determine if cadet or cadre
    CollectionReference cadres = FirebaseFirestore.instance.collection('cadres');
  }


  updateNickname(){
    /// update Nickname in database
    /// TODO: add if statement to determine if cadet or cadre
    CollectionReference cadres = FirebaseFirestore.instance.collection('cadres');

  }


  deleteNickname(){
    /// delete Nickname from database
    /// TODO: add if statement to determine if cadet or cadre
    CollectionReference cadres = FirebaseFirestore.instance.collection('cadres');
  }


  updateEmail(){
    /// update Email in database
    /// TODO: add if statement to determine if cadet or cadre
    CollectionReference cadres = FirebaseFirestore.instance.collection('cadres');
  }

  fetchEmail(){
    /// make Email public
    /// TODO: add if statement to determine if cadet or cadre
    CollectionReference cadres = FirebaseFirestore.instance.collection('cadres');
  }

  final TextStyle tabTextStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final TextStyle ranking =
      TextStyle(fontSize: 18, fontWeight: FontWeight.normal);
  final _textController = TextEditingController();

  bool iconPressed = false;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 25.0, bottom: 15.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: CircleAvatar(
                  backgroundColor: Colors.lightBlueAccent[200],
                  child: Text(
                    'JD',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.amber[200],
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  radius: 75.0,
                ),
              ),
            ),
            Text(
              'Cadre Doe',
              style: tabTextStyle,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Technical Sergeant',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Divider(
              thickness: 1,
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Nickname',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.edit_outlined,
                          color: Colors.amber[200],
                        ),
                        onPressed: () {
                          iconPressed = true;
                          readBio();
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Biography',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.edit_outlined,
                          color: Colors.amber[200],
                        ),
                        onPressed: () {
                          iconPressed = true;
                          readBio();
                          },
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40.0, 0.0, 255.0, 0.0),
                      child:Text(
                        profileData.toString(),
                      )
                  ),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



