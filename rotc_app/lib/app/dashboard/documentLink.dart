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

  }
}
