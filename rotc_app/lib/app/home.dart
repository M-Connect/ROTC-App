import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:rotc_app/app/Schedule/CalendarTasks.dart';
import 'package:rotc_app/app/dashboard/dashboard.dart';
import 'package:rotc_app/app/messaging/messaging.dart';
import 'package:rotc_app/app/peerReview/peerReviewLanding.dart';
import 'package:rotc_app/app/profile/profile.dart';
import 'package:rotc_app/common_widgets/buttonWidgets.dart';
import 'package:shared_preferences/shared_preferences.dart';

/*
  Author: Christine Thomas
  These classes make up the Cadre Control Panel Page.
  TODO: Modularize and Separate + add more content to tabs.
 */
/*
co-Author:  Kyle Serruys
co-Author:  Mac-Rufus Umeokolo
*/

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);
  @override
  _HomeView createState() => _HomeView();
}

bool isCadre = false;

/// This is the private state class that extends the State of CadreHome.
class _HomeView extends State<HomeView> {
  int _tabOption = 0;


  static List<Widget> _widgetOptions = <Widget>[
    Dashboard(),
    PeerReviewForm(),
    CalendarTasks(),
    messages(),
    Profile(),
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
        //toolbarHeight: 70.0,
        title: const Text("ROTC Control Panel",
        style: TextStyle(
            fontWeight: FontWeight.bold,
          fontSize: 25.0,
        ),
        ),
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
        backgroundColor: Colors.indigo,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_sharp),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.ballot_sharp),
            label: 'Evaluations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today_sharp),
            label: 'Schedule',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle_sharp),
            label: 'Account',
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

