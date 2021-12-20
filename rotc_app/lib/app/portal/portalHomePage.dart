import 'package:flutter/material.dart';

class PortalHomePage extends StatefulWidget {
  //const PortalHomePage({Key? key}) : super(key: key);

  @override
  _PortalHomePageState createState() => _PortalHomePageState();
}

class _PortalHomePageState extends State<PortalHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {},
        ),
        title: Text('Portal'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          // Box decoration takes a gradient
          gradient: LinearGradient(
            // Where the linear gradient begins and ends
            begin: Alignment.topRight,
            end: Alignment(0.3, 0),
            tileMode: TileMode.repeated, // repeats the gradient over the canvas
            colors: [
              Colors.white,
              Colors.lightBlue,
            ],
          ),
        ),
        child: Scrollbar(
          child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("data"),
                  ],
                ),
                color: Colors.teal[200],
              ),

              Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("data"),
                  ],
                ),
                color: Colors.teal[200],
              ),

              Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("data"),
                  ],
                ),
                color: Colors.teal[200],
              ),
                
              Container(
                padding: const EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("data"),
                  ],
                ),
                color: Colors.teal[200],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
