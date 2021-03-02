import 'package:flutter/material.dart';

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