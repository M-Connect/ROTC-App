import 'package:flutter/material.dart';

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
    Text('Test Home Page', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    Text('Test Message Page', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
    Text('Test Profile Page', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
          backgroundColor: Colors.blue
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>
          [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text('Home'),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.message),
                title: Text('Message'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
            ),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          backgroundColor: Colors.blue,
          selectedItemColor: Colors.white,
          iconSize: 30,
          onTap: _onItemTapped,
          elevation: 20
      ),
    );
  }
}





