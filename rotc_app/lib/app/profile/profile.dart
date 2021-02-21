import 'package:flutter/material.dart';

/*
  Author: Christine Thomas
  These classes make up the Cadre Control Panel Page.
  TODO: Modularize and Separate + add more content to tabs.
 */

class Profile extends StatelessWidget {
  final TextStyle tabTextStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  final TextStyle ranking =
  TextStyle(fontSize: 18, fontWeight: FontWeight.normal);
  final _textController = TextEditingController();




  @override
Widget build(BuildContext context) {
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
             Row(
          mainAxisSize: MainAxisSize.min,
            children: [
            IconButton(
            icon: Icon(
            Icons.edit_outlined,
          color: Colors.amber[200],
          ),
    onPressed: (){
      Navigator.pushNamed(context, '/editProfile');
    },
  ),
    ],
    ),
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

}
