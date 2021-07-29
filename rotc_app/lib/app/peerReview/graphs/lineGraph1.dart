import 'package:flutter/material.dart';

class LineGraph1 extends StatefulWidget {
 // const LineGraph({Key? key}) : super(key: key);

  @override
  _LineGraph1State createState() => _LineGraph1State();
}

class _LineGraph1State extends State<LineGraph1> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
        ),
      ),
    );
  }
}
