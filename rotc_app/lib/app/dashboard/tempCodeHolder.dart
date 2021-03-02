import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rotc_app/app/dashboard/documentLink.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';

/*
Author: Mac-Rufus O. Umeokolo

**/

class dashboard extends StatefulWidget {

  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {

  // The GlobalKey keeps track of the visible state of the list items
  // while they are being animated.
  final GlobalKey<AnimatedListState> _listKey = GlobalKey();

  // backing data
  List<String> _data = ['Sun', 'Moon', 'Star'];

  CollectionReference dashboardUrls =
  FirebaseFirestore.instance.collection('dashboardUrls');

  TextEditingController dashboardUrl = TextEditingController();

  TextEditingController documentNameText = TextEditingController();

  static const url =
      'https://docs.google.com/document/d/1izy6A08kGRre_oBplxPUsD6zNp8L5-Zhd_C7gJySg00/edit';

  Future<void> documentURLLink() {
    return dashboardUrls.add({
      'dashboardUrl': dashboardUrl.text,
      'documentNameText': documentNameText.text,
    });
  }

  bool isCadre = false;
  @override
  Widget build(BuildContext context) {
    const TextStyle tabTextStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => alertUploadURL(context),
        tooltip: 'upload document Url',
        child: const Icon(Icons.file_upload),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 300,
            child: AnimatedList(
              // Give the Animated list the global key
              key: _listKey,
              initialItemCount: _data.length,
              // Similar to ListView itemBuilder, but AnimatedList has
              // an additional animation parameter.
              itemBuilder: (context, index, animation) {
                // Breaking the row widget out as a method so that we can
                // share it with the _removeSingleItem() method.
                return _buildItem(_data[index], animation);
              },
            ),
          ),
          RaisedButton(
            child: Text('Insert item', style: TextStyle(fontSize: 20)),
            onPressed: () {
              _insertSingleItem();
            },
          ),
          RaisedButton(
            child: Text('Remove item', style: TextStyle(fontSize: 20)),
            onPressed: () {
              _removeSingleItem();
            },
          )
        ],
      ), /*Container(
        padding: EdgeInsets.all(25.0),
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              child: ElevatedButton(
                child: Text('Week 1 OPORD'),
                onPressed: () {
                  _launchURL();
                },
              ),
            ),
          ],
        ),
      ),*/
    );
  }
  _launchURL() async {
    try {
      closeWebView();

      if (await canLaunch(url)) {
        await launch(
          url,
          enableJavaScript: true,
          forceWebView: true,
        );
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      BuildContext context; //does this really work
      alertUrlError(context);
    }
  }

  alertUploadURL(BuildContext context) {
    dashboardUrl.clear();
    documentNameText.clear();
    AlertDialog alert = AlertDialog(
      title: Text("Upload Document URL"),
      content: SingleChildScrollView(
        // autovalidateMode: null,
        child: Column(
          children: [
            Text('Document Name'),
            SizedBox(height: 10),
            TextFormField(
              controller: documentNameText,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '\"Week 2 OPORD\"',
              ),
              validator: MultiValidator(
                  [RequiredValidator(errorText: 'Document Name is Required')]),
            ),
            SizedBox(height: 30),

            Text('Document URL'),
            SizedBox(height: 10),
            TextFormField(
              validator: MultiValidator([RequiredValidator(errorText: 'Document URL is Required'),
                PatternValidator(
                    r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)',
                    errorText: 'Must be a url'),
              ]),
              controller: dashboardUrl,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: '\"https://docs.google.com/document/...\"',
              ),
              toolbarOptions: ToolbarOptions(
                paste: true,
                cut: true,
                copy: true,
                selectAll: true,
              ),
            )
          ],
        ),
      ),

      actions: <Widget>[
        MaterialButton(
          elevation: 5.0,
          child: Text(
            'Post',
            style: TextStyle(
              color: Colors.blueAccent,
            ),
          ),
          onPressed: () async {
            _insertSingleItem();
            await documentURLLink();
            Navigator.of(context, rootNavigator: true).pop();
            dashboardUrl.clear();
            documentNameText.clear();

          },
        )
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );



    // This is the animated row with the Card.
    Widget _buildItem(String item, Animation animation) {
    }
  }

  void _insertSingleItem() {
    String newItem = "Planet";
    // Arbitrary location for demonstration purposes
    int insertIndex = 2;
    // Add the item to the data list.
    _data.insert(insertIndex, newItem);
    // Add the item visually to the AnimatedList.
    _listKey.currentState.insertItem(insertIndex);
  }

  void _removeSingleItem() {
    int removeIndex = 2;
    // Remove item from data list but keep copy to give to the animation.
    String removedItem = _data.removeAt(removeIndex);
    // This builder is just for showing the row while it is still
    // animating away. The item is already gone from the data list.
    AnimatedListRemovedItemBuilder builder = (context, animation) {
      return _buildItem(removedItem, animation);
    };
    // Remove the item visually from the AnimatedList.
    _listKey.currentState.removeItem(removeIndex, builder);
  }

  _buildItem(String item, Animation<double> animation) {
    return SizeTransition(
      sizeFactor: animation,
      child: Card(
        child: ListTile(
          title: Text(
            item,
            style: TextStyle(fontSize: 20),

          ),
        ),
      ),
    );
  }
}





alertUrlError(BuildContext context) {
  AlertDialog alert = AlertDialog(
    title: Text("Error"),
    content: Text("Document Url didn't launch."),
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}



