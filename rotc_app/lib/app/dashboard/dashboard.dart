/*import 'package:flutter/material.dart';
import 'package:rotc_app/app/peerReview/peerReviewLanding.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';

import '../../main.dart';
import '../home.dart';

/*
  Author: Christine Thomas
  These classes make up the Cadre Control Panel Page.
  TODO: Modularize and Separate + add more content to tabs.
 */

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);
  @override
  _CadreHomeState createState() => _CadreHomeState();
}

bool isCadre = true;

/// This is the private state class that extends the State of CadreHome.
class _CadreHomeState extends State<HomeView> {
  int _tabOption = 0;

  static List<Widget> _widgetOptions = <Widget>[
    dashboard(),
  ];

  void _chosenTab(int index) {
    setState(() {
      _tabOption = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadre Control Panel'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
              onPressed: () {
                alertSignOut(context);
              }),
        ],
        centerTitle: true,
      ),
      body: Center(
        child: _widgetOptions.elementAt(_tabOption),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
    body: SingleChildScrollView(
      child: Container(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'On Your Radar',
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
*/