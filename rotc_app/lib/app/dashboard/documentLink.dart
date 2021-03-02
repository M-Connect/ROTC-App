import 'package:flutter/material.dart';

class DocumentLink extends StatefulWidget {
  static Future<void> show(BuildContext context) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => DocumentLink(),
        fullscreenDialog: true,
      ),
    );
  }

  @override
  _DocumentLinkState createState() => _DocumentLinkState();
}

class _DocumentLinkState extends State<DocumentLink> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );


    /* Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          print('Card tapped.');
        },
        child: Container(
          width: 300,
          height: 100,
          child: Text('A card that can be tapped'),
        ),
      ),
    );*/
  }
}
