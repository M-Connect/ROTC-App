import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:rotc_app/app/profile/profile.dart';
import '../main.dart';

/*
  Author: Christine Thomas
  These classes make up the Cadre Control Panel Page.
  TODO: Modularize and Separate + add more content to tabs.
 */
/*
co-Author:  Kyle Serruys
*/

class MyAppNavBar extends StatefulWidget {
  MyAppNavBar({Key key}) : super(key: key);
  @override
  _MyTopNavBar createState() => _MyTopNavBar();
}

bool isCadre = false;


/// This is the private state class that extends the State of CadreHome.
class _MyTopNavBar extends State<MyAppNavBar> {
  int _tabOption = 0;

//  **** chat this List<Widget>*****
  static List<Widget> _widgetOptions = <Widget>[
    Profile(),
  ];


/*
  void _chosenTab(int option){
    setState(() {
      _tabOption = option;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control Panel'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
            onPressed: (){},


          ),
        ],
        centerTitle: true,
      ),
     /* body: Center(
        child: _widgetOptions.elementAt(_tabOption),
      ),*/
    );
  }
}


