import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

/*
  Author: Christine Thomas
  These classes make up the Cadre Control Panel Page.
  TODO: Modularize and Separate + add more content to tabs.
 */

class CadreHome extends StatefulWidget {
  CadreHome({Key key}) : super(key: key);

  @override
  _CadreHomeState createState() => _CadreHomeState();
}

/// This is the private state class that extends the State of CadreHome.
class _CadreHomeState extends State<CadreHome> {
  int _tabOption = 0;

  List<Widget> tabThrough() {
    List<Widget> _widgetOptions = <Widget>[
      dashboard(),
      peerReviewForm(),
      messages(),
      profile()
    ];
    return _widgetOptions;
  }

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
        centerTitle: true,
      ),
      body: Center(
        child: tabThrough().elementAt(_tabOption),
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
        unselectedItemColor: Theme
            .of(context)
            .primaryColorLight,
        selectedItemColor: Theme
            .of(context)
            .accentColor,
        onTap: _chosenTab,
      ),
    );
  }

  /// NOT FUNCTIONAL YET
  Widget profile() {
    const TextStyle tabTextStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    const TextStyle ranking =
    TextStyle(fontSize: 18, fontWeight: FontWeight.normal);
    final _textController = TextEditingController();
    String biography = '';

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
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
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0.0, 10.0, 255.0, 10.0),
                    child: GestureDetector(
                      child: Text(
                        'Biography',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      onTap: () {
                        AlertDialog(
                          title: Text(
                            'Biography',
                          ),
                          content: TextField(
                            onChanged: (value) {
                              setState(() {
                                biography = value;
                              });
                            },
                            controller: _textController,
                          ),
                          actions: [
                            FlatButton(
                              color: Colors.amber[200],
                              textColor: Colors.white,
                              child: Text('Done'),
                              onPressed: () {
                                setState(() {

                                });
                              },
                            )
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    width: 330.0,
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: 'Tell us about yourself',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.elliptical(10, 10),
                          ),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                        ),
                      ),
//maxLines: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
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

Widget peerReviewForm() {
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
                  'Peer Review Forms',
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

