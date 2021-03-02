import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:rotc_app/app/dashboard/documentLink.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:provider/provider.dart';


import 'package:flutter/foundation.dart';

/*
Author: Mac-Rufus O. Umeokolo

**/

class dashboard extends StatefulWidget {
  @override
  _dashboardState createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {

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


  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  ListModel<int> _list;
  int _selectedItem;
  int _nextItem; // The next item inserted when the user presses the '+' button.

  @override
  void initState() {
    super.initState();
    _list = ListModel<int>(
      listKey: _listKey,
      initialItems: <int>[0, 1, 2],
      removedItemBuilder: _buildRemovedItem,
    );
    _nextItem = 3;
  }

  // Used to build list items that haven't been removed.
  Widget _buildItem(
      BuildContext context, int index, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: _list[index],
      selected: _selectedItem == _list[index],
      onTap: () {
        setState(() {
          _selectedItem = _selectedItem == _list[index] ? null : _list[index];
        });
      },
    );
  }



  Widget _buildRemovedItem(
      int item, BuildContext context, Animation<double> animation) {
    return CardItem(
      animation: animation,
      item: item,
      selected: false,
      // No gesture detector here: we don't want removed items to be interactive.
    );
  }

  // Insert the "next item" into the list model.
  void _insert() {
    final int index =
    _selectedItem == null ? _list.length : _list.indexOf(_selectedItem);
    _list.insert(index, _nextItem++);
  }

  // Remove the selected item from the list model.
  void _remove() {
    if (_selectedItem != null) {
      _list.removeAt(_list.indexOf(_selectedItem));
      setState(() {
        _selectedItem = null;
      });
    }
  }



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
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.add_circle),
              onPressed: _insert,
              tooltip: 'insert a new item',
            ),
            IconButton(
              icon: const Icon(Icons.remove_circle),
              onPressed: _remove,
              tooltip: 'remove the selected item',
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedList(
            key: _listKey,
            initialItemCount: _list.length,
            itemBuilder: _buildItem,
          ),
        ),
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
              validator: MultiValidator([
                RequiredValidator(errorText: 'Document URL is Required'),
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
}




/// Keeps a Dart [List] in sync with an [AnimatedList].
///
/// The [insert] and [removeAt] methods apply to both the internal list and
/// the animated list that belongs to [listKey].
///
/// This class only exposes as much of the Dart List API as is needed by the
/// sample app. More list methods are easily added, however methods that
/// mutate the list must make the same changes to the animated list in terms
/// of [AnimatedListState.insertItem] and [AnimatedList.removeItem].
class ListModel<E> {
  ListModel({
    @required this.listKey,
    @required this.removedItemBuilder,
    Iterable<E> initialItems,
  })  : assert(listKey != null),
        assert(removedItemBuilder != null),
        _items = List<E>.from(initialItems ?? <E>[]);

  final GlobalKey<AnimatedListState> listKey;
  final dynamic removedItemBuilder;
  final List<E> _items;

  AnimatedListState get _animatedList => listKey.currentState;

  void insert(int index, E item) {
    _items.insert(index, item);
    _animatedList.insertItem(index);
  }

  E removeAt(int index) {
    final E removedItem = _items.removeAt(index);
    if (removedItem != null) {
      _animatedList.removeItem(
        index,
            (BuildContext context, Animation<double> animation) =>
            removedItemBuilder(removedItem, context, animation),
      );
    }
    return removedItem;
  }

  int get length => _items.length;

  E operator [](int index) => _items[index];

  int indexOf(E item) => _items.indexOf(item);
}

/// Displays its integer item as 'item N' on a Card whose color is based on
/// the item's value.
///
/// The text is displayed in bright green if [selected] is
/// true. This widget's height is based on the [animation] parameter, it
/// varies from 0 to 128 as the animation varies from 0.0 to 1.0.
class CardItem extends StatelessWidget {
  const CardItem(
      {Key key,
        @required this.animation,
        this.onTap,
        @required this.item,
        this.selected = false})
      : assert(animation != null),
        assert(item != null && item >= 0),
        assert(selected != null),
        super(key: key);

  final Animation<double> animation;
  final VoidCallback onTap;
  final int item;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline4;
    if (selected)
      textStyle = textStyle.copyWith(color: Colors.lightGreenAccent[400]);
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: SizeTransition(
        axis: Axis.vertical,
        sizeFactor: animation,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          child: SizedBox(
            height: 80.0,
            child: Card(
              color: Colors.primaries[item % Colors.primaries.length],
              child: Center(
                child: Text('Item $item', style: textStyle),
              ),
            ),
          ),
        ),
      ),
    );
  }
}