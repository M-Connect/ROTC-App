import 'package:flutter/material.dart';

import '../../main.dart';

/*
  Author: Christine Thomas
  These classes make up the Cadre Control Panel Page.
  TODO: Modularize and Separate + add more content to tabs.

co-Author:  Kyle Serruys
added buttons and navigation for those buttons
*/

class PeerReviewLanding extends StatefulWidget {
  PeerReviewLanding({Key key}) : super(key: key);
  @override
  _CadreHomeState createState() => _CadreHomeState();
}

bool isCadre = true;

/// This is the private state class that extends the State of CadreHome.
class _CadreHomeState extends State<PeerReviewLanding> {
  int _tabOption = 0;

  static List<Widget> _widgetOptions = <Widget>[
    dashboard(),
    peerReviewForm(),
    messages(),
    profile()
  ];

  void _chosenTab(int option) {
    setState(() {
      _tabOption = option;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Peer Review Control Panel'),

        automaticallyImplyLeading: false,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
            onPressed: () {},
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
        selectedItemColor: Theme.of(context).accentColor,
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
              child: Text('Review Request Announcement'),
              onPressed: () {
                navigation.currentState.pushNamed('/peerReview');
              },
            ),
          ),
          Container(
            child: ElevatedButton(
              child: Text('Lead Lab OPORD'),
              onPressed: () {
                navigation.currentState.pushNamed('/peerReview');
              },
            ),
          ),
          Container(
            child: ElevatedButton(
              child: Text('PT ConOps'),
              onPressed: () {},
            ),
          ),
        ],
      ),
    ),
  );
}

@override
Widget peerReviewForm() {
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
              onPressed: () {
                navigation.currentState.pushNamed('/peerReview');
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

Widget profile() {
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
                'Profile',
                style: tabTextStyle,
              ),
            ),
            Column(
              children: [],
            ),
          ],
        ),
      ),
    ),
  );
}
