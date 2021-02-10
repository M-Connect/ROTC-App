import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/*
Sawyer Kisha
02/05/2021
1.0 - Prototype 01
Ui for the cadet home page
*/

class MyApp extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      home: CadetHome (),
    );
  }
}

class CadetHome extends StatefulWidget
{
  CadetHome ({Key key}) : super(key: key);
  @override
  _CadetHome createState() => _CadetHome();
}

class _CadetHome extends State<CadetHome>
{
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text('Dashboard Page', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    Text('Peer Review Form Page', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    Text('Messenger Page', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    Text('Profile Page', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
  ];

  void _onItemTapped(int index)
  {
    setState(()
    {
      _selectedIndex = index;
    }
    );
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
          title: const Text('Cadet Home'),
          backgroundColor: Colors.lightBlueAccent[200],
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>
          [
            BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_sharp),
                title: Text('Dashboard'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.ballot_sharp),
                title: Text('Peer Review'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              title: Text('Message'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_sharp),
              title: Text('Profile'),
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          backgroundColor: Colors.lightBlueAccent[200],
          //selectedItemColor: Colors.white,
          //iconSize: 30,
          //elevation: 20,
          onTap: _onItemTapped,
          unselectedItemColor: Theme.of(context).primaryColorLight,
          selectedItemColor: Theme.of(context).accentColor,
      ),
    );
  }
}





