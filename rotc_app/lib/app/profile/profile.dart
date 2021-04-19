import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rotc_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
  Author: Christine Thomas
  These classes fetch the currently signed in user info and display it
  on the user's profile page. There is also a button
  next to their name to route them to their evaluation data.
 */

class Profile extends StatefulWidget {
  TextEditingController email;
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  /// adding reference to database for profile collection path use
  CollectionReference profiles =
      FirebaseFirestore.instance.collection('profiles');

  bool isCadre;

  /*
  This function gets an instance of SharedPreferences object called prefs and
  checks if the isCadre field in the database is true and sets isCadre to
  true if so.
   */
  getBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isCadre = prefs.getString('isCadre') == 'true';
    });
  }

  // Unused code that could be utilized in the future
/*  Map<String, dynamic> biography;
  Map profileData;

  ///
  /// This function gives a user a blank biography upon registration.
  Future<void> createBio() async {
    /// Referencing the cadre collection to get number of documents
    /// to create custom document name for user to be able to update
    /// their own biography.
    CollectionReference cadre = FirebaseFirestore.instance.collection('cadres');
    cadre.snapshots().listen((snapshot) {
      List docs;
      docs = snapshot.docs;
      int numberOfDocs = docs.length;
      print('$numberOfDocs');
    });

    Map<String, dynamic> bioText = {'biography': 'Add a bio'};
    CollectionReference profiles =
        FirebaseFirestore.instance.collection('profiles');
    profiles.add(bioText);
  }

  readBio() {
    /// make Biography public
    CollectionReference profiles =
        FirebaseFirestore.instance.collection('profiles');
    profiles.snapshots().listen((snapshot) {
      setState(() {
        // QueryDocumentSnapshot data = snapshot.docs[0];
        profileData = snapshot.docs[0].data();
      });
    });
    //profileCollection['biography'].toString();
  }

  updateBio({Map<String, dynamic> biography}) {
    /// update Biography in database
    CollectionReference profiles =
        FirebaseFirestore.instance.collection('profiles');
    String docId;

    profiles
        .doc()
        .set({'biography': 'sup homie'})
        .then((value) => print('Profile updated'))
        .catchError((error) => print('Failed to update'));
  }

  /// May need to update Firestore plugin...
  deleteBio() async {
    /// delete Biography from database
    CollectionReference profiles =
        FirebaseFirestore.instance.collection('profiles');
  }

  updateEmail() {
    /// update Email in database
    CollectionReference cadres =
        FirebaseFirestore.instance.collection('cadres');
  }

  fetchEmail() {
    /// make Email public
    CollectionReference cadres =
        FirebaseFirestore.instance.collection('cadres');
  }*/

  // Creating variables for easier styling
  final TextStyle tabTextStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final TextStyle ranking =
      TextStyle(fontSize: 18, fontWeight: FontWeight.normal);
  final _textController = TextEditingController();

  /* Declaring and initializing needed fields related to user info:
  Their first name = fName
  Last name = lName
  Nickname (if they gave one) = nName
  and email.
   */
  String fName = '';
  String lName = '';
  String nName = '';
  static String email = '';

  //bool iconPressed = false;

  /*
  Initializing the state of the application
   */
  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  /*
  This function gets the currently signed-in user's firstName,
  lastName, nickName (if they have one) and email from the database
  and sets it to the string variables fName, lName, nName, and email
  respectively.
   */
  getUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fName = prefs.getString('firstName');
      lName = prefs.getString('lastName');
      nName = prefs.getString('nickname');
      email = prefs.getString('email');
    });
  }

  /*
  The build function then displays the fetched data and sets the rank to Cadet or
  Cadre depending on the signed-in user's access / credential type. i.e,
  if they are a Cadet they are listed as such and same goes for Cadre.
   */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            /*Padding(
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
            ),*/
            Center(
              child: Container(
                padding: EdgeInsets.only(
                  bottom: 20,
                  top: 30,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(70.0),
                    bottomLeft: Radius.circular(70.0),
                  ),
                  color: Colors.blue.shade900,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('$fName' + ' $lName',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        )),
                    IconButton(
                      icon: Icon(
                        Icons.bar_chart,
                        size: 30,
                        color: Colors.cyan,
                      ),
                      onPressed: () {
                        navigation.currentState.pushNamed('/barGraph');
                      },
                      tooltip: 'Click here to view your stats.',
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: 20, right: 20, top: 16.0),
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Ranking',
                      style: TextStyle(
                        color: Colors.cyan,
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                      ),
                    ),
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
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Nickname',
                      style: TextStyle(
                        color: Colors.cyan,
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      ' $nName',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.cyan,
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      ' $email',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Divider(),
                  /* Row(
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
                  ),*/
                ],
              ),
            ),
            // Unused code that can be utilized in the future.
            /*  Container(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  */ /* Text(
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
                  ),*/ /*
                ],
              ),
            ),*/
            /*Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                      padding: const EdgeInsets.fromLTRB(40.0, 0.0, 255.0, 0.0),
                      child: IconButton(
                        icon: Icon(
                          Icons.bar_chart,
                        ),
                        onPressed: () {
                          navigation.currentState.pushNamed('/barGraph');
                        },
                      )),
                ],
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
