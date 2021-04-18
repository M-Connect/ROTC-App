import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:googleapis_auth/auth.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:rotc_app/Views/GCEventsList.dart';
import 'package:rotc_app/app/Schedule/ViewModels/gc_event_ops.dart';
import 'package:rotc_app/app/Schedule/toDoList.dart';
import 'package:rotc_app/services/gc_client_codes.dart';
import 'package:rotc_app/services/gc_event_crud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:googleapis/calendar/v3.dart' as schedules;
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

//Author: Christine Thomas
// Date: 3/6/2021
// This class lets the user add tasks to a day they choose on the calendar
// and shows the list of tasks underneath upon clicking the day again.

class CalendarTasks extends StatefulWidget {
  @override
  _CalendarTasksState createState() => _CalendarTasksState();
}

class _CalendarTasksState extends State<CalendarTasks> {
  GCEventCRUD eventCRUD = GCEventCRUD();
  CalendarController _calendarController = CalendarController();
  Map<DateTime, List<dynamic>> _tasks;
  List<dynamic> _tasksChosen;
  TextEditingController _taskController;
  SharedPreferences prefs;
  String evaluationDate = "";
  bool isCadre = false;

  /*
  This method initializes the state of the CalendarController,
  the TextEditingController, the _tasks map, the array of _tasksChosen.
  * */
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _taskController = TextEditingController();
    _tasks = {};
    _tasksChosen = [];
    sharedPrefsData();
    getBool();
    //_loadButtonPressed();
    //getEvaluationDate();
  }

  getBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isCadre = prefs.getString('isCadre') == 'true';
    });
  }

  getEvaluationDate() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      evaluationDate = prefs.getString('evaluationDate');
    });
  }

  sharedPrefsData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _tasks = Map<DateTime, List<dynamic>>.from(
          decode(json.decode(prefs.getString("tasks") ?? "{}")));
    });
  }

  /*
  This method takes a map of type Map<DateTime, dynamic>
  Within this method is a Map that maps a String key with a dynamic value
  of any type, called theMapping.
  For each key-value pair of the map parameter, theMapping takes the map's DateTime key
  as a string.
  * */
  Map<String, dynamic> encode(Map<DateTime, dynamic> map) {
    Map<String, dynamic> theMapping = {};
    map.forEach((key, value) {
      theMapping[key.toString()] = map[key];
    });
    return theMapping;
  }

  Map<DateTime, dynamic> decode(Map<String, dynamic> mapping) {
    Map<DateTime, dynamic> theMapping = {};
    mapping.forEach((key, value) {
      theMapping[DateTime.parse(key)] = mapping[key];
    });
    return theMapping;
  }

  _loadButtonPressed() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      final completed = (prefs.getBool('completed') ?? false);
    });
  }

  _savedBoolValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setBool('completed', true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0),
          child: AppBar(
            backgroundColor: Colors.white,
            bottom: TabBar(
              labelColor: Colors.blue.shade900,
              tabs: [
                Tab(
                  text: 'Calendar',
                ),
                Tab(
                  text: 'Upcoming',
                ),
                Tab(text: 'To-Dos')
              ],
            ),
          ),
        ),
        body: TabBarView(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Card(
                        shape: Border.all(
                          color: Colors.black26,
                        ),
                        shadowColor: Colors.black54,
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Column(
                            children: [
                              TableCalendar(
                                events: _tasks,
                                availableCalendarFormats: const {
                                  CalendarFormat.month: 'Month'
                                },
                                headerStyle: HeaderStyle(
                                  //headerPadding: EdgeInsets.only(bottom: 1),
                                  decoration: BoxDecoration(
                                    color: Colors.cyan.shade500,
                                  ),
                                  centerHeaderTitle: true,
                                  titleTextStyle: TextStyle(
                                    fontSize: 30,
                                    letterSpacing: 1.5,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  leftChevronIcon: Icon(
                                    Icons.arrow_back_ios_outlined,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  rightChevronIcon: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                  headerMargin: EdgeInsets.only(bottom: 8.0),
                                  formatButtonVisible: false,
                                ),
                                startingDayOfWeek: StartingDayOfWeek.sunday,
                                onDaySelected: (date, events, holidays) {
                                  setState(() {
                                    _tasksChosen = events;
                                  });
                                },
                                daysOfWeekStyle: DaysOfWeekStyle(
                                  weekdayStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  weekendStyle: TextStyle(
                                    color: Colors.cyanAccent.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                calendarStyle: CalendarStyle(
                                  canEventMarkersOverflow: true,
                                  todayColor: Colors.amberAccent,
                                  weekendStyle: TextStyle(
                                    color: Colors.cyanAccent.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  outsideWeekendStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  outsideStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  outsideDaysVisible: true,
                                  selectedColor: Colors.cyan.shade500,
                                  markersMaxAmount: 3,
                                  markersColor: Colors.cyanAccent,
                                  cellMargin: EdgeInsets.all(5),
                                  todayStyle: TextStyle(
                                      fontSize: 20.0, color: Colors.black),
                                ),
                                calendarController: _calendarController,
                              ),
                              Row(
                                mainAxisAlignment: isCadre
                                    ? MainAxisAlignment.spaceAround
                                    : MainAxisAlignment.end,
                                children: [
                                  Visibility(
                                    visible: isCadre == true,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        launchGC();
                                        navigation.currentState
                                            .pushNamed('/addGCEvent');
                                      },
                                      child: Text(
                                        'ADD A GOOGLE CALENDAR EVENT',
                                        style: TextStyle(
                                          color: Colors.purpleAccent,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 16.0),
                                    child: OutlinedButton(
                                      onPressed: () {
                                        _addTaskDialog();
                                      },
                                      child: Text(
                                        'ADD A TASK',
                                        style: TextStyle(
                                          color: Colors.purpleAccent,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Padding(
                  // padding: const EdgeInsets.only(left: 20.0, right: 20.0),

                  // ),
                  ..._tasksChosen.map(
                    (task) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Card(
                            color: Colors.cyan.shade400,
                            shadowColor: Colors.black54,
                            elevation: 8,
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  title: Text(
                                    task,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                  leading: IconButton(
                                    icon: Icon(
                                      Icons.close,
                                      color: Colors.redAccent,
                                      size: 30,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _tasks[_calendarController.selectedDay]
                                            .remove(task);
                                        prefs.setString("tasks",
                                            json.encode(encode(_tasks)));
                                        _taskController.clear();
                                      });
                                    },
                                  ),

                                  /* trailing: IconButton(
                                        icon: Icon(
                                          Icons.check_circle_outline,
                                          color: Colors.grey,

                                        ),

                                        onPressed: () {
                                          setState(() {
                                            _savedBoolValue();
                                          });

                                        }
                                        ),*/
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GCEventsList(),
            ToDoList(),
            //Navigator.of(context).pushNamed('/GCEventsList');
          ],
        ),

        /* floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          child: Icon(
            Icons.add,
          ),
          onPressed: _addTaskDialog,
        ),*/
      ),
    );
  }

  _addTaskDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: Text("Add a new task"),
              content: TextField(
                controller: _taskController,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    "ADD",
                    style: TextStyle(
                        color: Colors.purpleAccent,
                        fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    if (_taskController.text.isEmpty) return;
                    setState(() {
                      if (_tasks[_calendarController.selectedDay] != null) {
                        _tasks[_calendarController.selectedDay]
                            .add(_taskController.text);
                      } else {
                        _tasks[_calendarController.selectedDay] = [
                          _taskController.text
                        ];
                      }
                      prefs.setString("tasks", json.encode(encode(_tasks)));
                      _taskController.clear();
                      Navigator.pop(context);
                    });
                  },
                )
              ],
            ));
  }
}

/*
This method  creates a new ClientId instance, that calls the GCClientCodes class
at accesses the getCodes method and returns the platform client ID.
 * the _scope imports the googleapis/calendar/v3.dart as schedules, accesses the CalendarApi
 *  to manipulate events/calendar data, and accesses the calendarScope which allows for
 * viewing, editing, sharing, and deleting all calendars using the API.

///TODO talk about scope and clientViaUserConsent
* the method awaits the clientViaUserConsent which takes the _clientId, the _scope, and the message
* and gets oauth2 credentials and returns the authenticated HTTP client.
* This function then defines the GCEventOps class variable schedules to be the Google Calendar of the
   account the user gives the app access to.
 */

Future<void> launchGC() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var _clientId = new ClientId(GCClientCodes.getCodes(), "");
  const _scope = const [schedules.CalendarApi.calendarScope];
  await clientViaUserConsent(_clientId, _scope, message)
      .then((AuthClient client) async {
    GCEventOps.schedule = schedules.CalendarApi(client);
  });
}

/*
* this method takes a url of type String and checks if the url
* parameter can be launched by the app.
* If it can it parses the url string parameter and lets the platform handle it as it will.
  Else if canLaunch returns false a PlatformException error code will be thrown*/
void message(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Failure launching $url';
  }
}
