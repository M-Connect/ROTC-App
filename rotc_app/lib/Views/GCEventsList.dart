import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rotc_app/Views/updateGCEvent.dart';
import 'package:rotc_app/app/Schedule/Models/gc_event_model.dart';
import 'package:rotc_app/services/gc_event_crud.dart';

class GCEventsList extends StatefulWidget {
  @override
  _GCEventsListState createState() => _GCEventsListState();
}

class _GCEventsListState extends State<GCEventsList> {
  GCEventCRUD eventCRUD = GCEventCRUD();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 16.0),
        child: StreamBuilder(
            stream: eventCRUD.readAllGCEvents(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.docs.length > 0) {
                  return ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> eventData = snapshot.data.docs[index].data();

                      GCEventModel event = GCEventModel.mapData(eventData);

                      DateTime startTimeData = DateTime.fromMillisecondsSinceEpoch(event.startTime);
                      DateTime endTimeData = DateTime.fromMillisecondsSinceEpoch(event.endTime);

                      String startTimeString = DateFormat.jm().format(startTimeData);
                      String endTimeString = DateFormat.jm().format(endTimeData);
                      String dateString = DateFormat.yMMMMd().format(startTimeData);

                      return Card(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '${event.title}',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 25,
                                          ),
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.edit_sharp,
                                            size: 25,
                                            color: Colors.amber,
                                          ),
                                          onPressed: (){
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) => UpdateGCEvent(event: event)
                                              ),
                                            );
                                          },
                                        ),
                                       /* IconButton(
                                          icon: Icon(
                                            Icons.clear_sharp

                                          ),
                                        ),*/
                                      ],
                                    ),

                                    SizedBox(height: 10),
                                    Text(
                                      event.details ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        color: Colors.black38,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                        letterSpacing: 1,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 30,
                                          width: 5,
                                        ),
                                        SizedBox(width: 10),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              dateString,
                                              style: TextStyle(
                                                color: Colors.lightBlue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                letterSpacing: 1.5,
                                              ),
                                            ),
                                            Text(
                                              '$startTimeString - $endTimeString',
                                              style: TextStyle(
                                                color: Colors.lightBlue,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                                letterSpacing: 1.5,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                    ],
                                ),
                              ),
                            ],
                          ),
                      );
                    },
                  );
                } else {
                  return Center(
                    child: Text(
                      'No Upcoming Events',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  );
                }
              }
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,

                ),
              );
            },
        ),
      ),
    );
  }
}