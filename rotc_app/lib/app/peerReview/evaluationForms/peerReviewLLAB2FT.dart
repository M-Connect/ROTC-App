import 'package:flutter/material.dart';
import 'package:animated_button/animated_button.dart';
import '../../../main.dart';
import '../peerReviewLanding.dart';

/*
 Author: Kyle Serruys
  This class is the home page for our LLAB2FT peer review
 */

class PeerReviewLLAB2FT extends StatelessWidget {
  static final SizedBox spaceBetweenFields = SizedBox(height: 40.0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Navigator.pop(context);
            //navigation.currentState.pop();
            navigation.currentState.pushNamed('/homePage');
          },
        ),
        title: Text('Evaluation'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(19.0),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Center(
              child: AnimatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.subtitles_outlined,
                        size: 32.5,
                        color: Colors.white,
                      ),
                      SizedBox(width: 6),
                      Text(
                        '          Planning',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  navigation.currentState.pushNamed('/planning');
                },
                width: 350,
                height: 60,
                shadowDegree: ShadowDegree.dark,
                duration: 100,
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            Center(
              child: AnimatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.phone_in_talk,
                        size: 32.5,
                        color: Colors.white,
                      ),
                      SizedBox(width: 6),
                      Text(
                        '     Communication',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  navigation.currentState.pushNamed('/communication');
                },
                width: 350,
                height: 60,
                shadowDegree: ShadowDegree.dark,
                duration: 100,
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            Center(
              child: AnimatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.sports_kabaddi_outlined,
                        size: 32.5,
                        color: Colors.white,
                      ),
                      SizedBox(width: 6),
                      Text(
                        '          Execution',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  navigation.currentState.pushNamed('/execution');
                },
                width: 350,
                height: 60,
                shadowDegree: ShadowDegree.dark,
                duration: 100,
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            Center(
              child: AnimatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.sports_outlined,
                        size: 32.5,
                        color: Colors.white,
                      ),
                      SizedBox(width: 6),
                      Text(
                        '         Leadership',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  navigation.currentState.pushNamed('/leadership');
                },
                width: 350,
                height: 60,
                shadowDegree: ShadowDegree.dark,
                duration: 100,
              ),
            ),
            SizedBox(
              height: 6.0,
            ),
            Center(
              child: AnimatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Icon(
                        Icons.supervised_user_circle,
                        size: 32.5,
                        color: Colors.white,
                      ),
                      SizedBox(width: 6),
                      Text(
                        '            Debrief',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  navigation.currentState.pushNamed('/debrief');
                },
                width: 350,
                height: 60,
                shadowDegree: ShadowDegree.dark,
                duration: 100,
              ),
            ),
            spaceBetweenFields,
            SizedBox(
              height: 15.0,
            ),
            Center(
              child: AnimatedButton(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Confirmation',
                        style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                onPressed: () {
                  navigation.currentState.pushNamed('/confirmation');
                },
                width: 350,
                height: 75,
                shadowDegree: ShadowDegree.dark,
                duration: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
