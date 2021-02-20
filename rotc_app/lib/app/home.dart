import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../main.dart';

/*
  Author: Christine Thomas
  These classes make up the Cadre Control Panel Page.
  TODO: Modularize and Separate + add more content to tabs.
 */
/*
co-Author:  Kyle Serruys
*/

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);
  @override
  _CadreHomeState createState() => _CadreHomeState();
}

bool isCadre = false;


/// This is the private state class that extends the State of CadreHome.
class _CadreHomeState extends State<HomeView> {
  int _tabOption = 0;

  static List<Widget> _widgetOptions = <Widget>[
    dashboard(),
    peerReviewForm(),
    messages(),
    profile()
  ];



  void _chosenTab(int option){
    setState(() {
      _tabOption = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control Panel'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
            onPressed: () {

            },
          ),
        ],
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_tabOption),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.indigo,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_sharp),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ballot_sharp),
            label: 'Peer Review Forms',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_sharp),
            label: 'Profile',
          ),
        ],
        currentIndex: _tabOption,
        unselectedItemColor: Theme.of(context).primaryColorLight,
        //unselectedItemColor: Colors.indigo,
        selectedItemColor: Theme.of(context).accentColor,
       // selectedItemColor: Colors.black87,
        onTap: _chosenTab,
      ),
    );
  }
}

Widget dashboard() {
  const TextStyle tabTextStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  return Scaffold(
    body: Container(
      padding: EdgeInsets.all(25.0),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: ElevatedButton(
              child: Text('Review Request Anouncement'),
              onPressed: (){
                navigation.currentState.pushNamed('');
              },
            ),
          ),
          Container(
            child: ElevatedButton(
              child: Text('Lead Lab OPORD'),
              onPressed: (){
                navigation.currentState.pushNamed('');
              },
            ),
          ),
          Container(
            child: ElevatedButton(
              child: Text('PT ConOps'),
              onPressed: () {
                navigation.currentState.pushNamed('');
              },
            ),
          ),
        ],
      ),
    ),
  );
}

@override
Widget peerReviewForm( ) {
  const TextStyle tabTextStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  return Scaffold(
    body: Container(
      padding: EdgeInsets.all(25.0),
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            child: ElevatedButton(
              child: Text('Peer Review'),
              onPressed: (){
                navigation.currentState.pushNamed('/peerReviewLanding');
              },
            ),
          ),
          Visibility(
            visible: isCadre == true,
            child: Container(
              child: ElevatedButton(
                child: Text('Request a Peer Review'),
                onPressed: () {
                  navigation.currentState.pushNamed('/peerReviewRequest');
                },
              ),
            ),
          ),
          Container(
            child: ElevatedButton(
              child: Text('Review Stats'),
              onPressed: () {
                navigation.currentState.pushNamed('/peerReviewStats');
              },
            ),
          ),
        ],
      ),
    ),
  );
}

Widget messages() {
  const TextStyle tabTextStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  return Scaffold(
    body: SingleChildScrollView(
      child: Container(
          child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              'Messages',
              style: tabTextStyle,
            ),
          ),
          Column(
            children: [],
          ),
        ],
      )),
    ),
  );
}

Widget profile(){
  const TextStyle tabTextStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  const TextStyle ranking =
  TextStyle(fontSize: 18, fontWeight: FontWeight.normal);
  final _textController = TextEditingController();
  final editDialog =  SimpleDialog(
    title: Text(
        'Edit Biography'
    ),
    children: [
      TextField(
        onChanged: (text) {
          print("First text field: $text");
        },
      ),

    ],
  );
  final icon =  Row(
  mainAxisSize: MainAxisSize.min,
  children: [
  IconButton(
      icon: Icon(
        Icons.edit_outlined,
          color: Colors.amber[200],
      ),
    onPressed: (){
    },
  ),
  ],
  );

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
          'Biography',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
            fontSize: 20,
          ),
        ),
        icon,
      ],
    ),
  ),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(40.0, 0.0, 255.0, 0.0),
    ),

              ],
            ),
          ],
        ),
      ),
  );
}
