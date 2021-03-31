import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';

//Author: Christine Thomas
// Date: 3/6/2021
// This class lets the user add tasks to a day they choose on the calendar
// and shows the list of tasks underneath upon clicking the day again.

class CalendarTasks extends StatefulWidget {
  @override
  _CalendarTasksState createState() => _CalendarTasksState();
}

class _CalendarTasksState extends State<CalendarTasks> {
  CalendarController _calendarController = CalendarController();
  Map<DateTime, List<dynamic>> _tasks;
  List<dynamic> _tasksChosen;
  var userEvaluations = Map<String, DateTime>();
  TextEditingController _taskController;
  SharedPreferences prefs;
  String evaluationDate = "";
  var evaluationsForToday = List<String>();
  
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _taskController = TextEditingController();
    _tasks = {};
    _tasksChosen = [];
    sharedPrefsData();
    _loadButtonPressed();
    getEvaluationDate();
    getUserEvaluations();
  }

  /*
  * Author:  Kyle Serruys
  * getUserEvaluations stores the requested evaluations for the current user.  This allows
  * the user to see which evaluations are due on which days.  Once an evaluation is marked
  * complete it will be removed from this calendar view.
  * */

  getUserEvaluations() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var firstName = prefs.getString('firstName');
    var lastName =  prefs.getString('lastName');
    var userName = firstName + " " + lastName;
    var data = await FirebaseFirestore.instance
        .collection('userEvaluationRequests')
        .get()
        .then((docSnapshot) {
      docSnapshot.docs.forEach((element) {
        var evaluator = element.data()['evaluator'].toString();
        var evaluatee = element.data()['evaluatee'].toString();
        var status = element.data()['status'].toString();
        var activity = element.data()['activity'].toString();
        var evalDate = DateTime.parse(element.data()['evaluationDate'].toString());

        if(evaluator == userName && status != "Complete" ) {
          var key = evaluatee + "|" + activity + "|" + userEvaluations.length.toString();
          userEvaluations[key] = evalDate;
        }

      });
    });
    setState(() {

    });
  }

  getEvaluationDate()async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
     evaluationDate = prefs.getString('evaluationDate');
    });
  }

  sharedPrefsData() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _tasks = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> mapping) {
    Map<String, dynamic> theMapping = {};
    mapping.forEach((key, value) {
      theMapping[key.toString()] = mapping[key];
    });
    return theMapping;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> mapping) {
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
    return Scaffold(
      /*appBar: AppBar(
        title: Text('Schedule'),
        centerTitle: true,
      ),*/
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            TableCalendar(
              events: _tasks,
              availableCalendarFormats: const {CalendarFormat.month: 'Month'},

              headerStyle: HeaderStyle(
                centerHeaderTitle: true,
                titleTextStyle: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
                leftChevronIcon: Icon(
                  Icons.arrow_back_ios_outlined,
                  size: 30,
                ),
                rightChevronIcon: Icon(
                  Icons.arrow_forward_ios_outlined,
                  size: 30,
                ),
                headerMargin: EdgeInsets.only(bottom: 8.0),
                formatButtonVisible: false,
              ),
              startingDayOfWeek: StartingDayOfWeek.sunday,
              onDaySelected: (date, events, holidays) {
                print("day selected");
                evaluationsForToday.clear();

               // _tasksChosen.clear();
                userEvaluations.forEach((key, value) {
                  var selectedDay = date;
                  var tomorrow = selectedDay.add(const Duration(days: 1));

                  if((value.isAfter(selectedDay) || value.isAtSameMomentAs(selectedDay)) && (value.isBefore(tomorrow)) ) {
                    var tempArray =  key.split("|");
                    var item = "Evaluate: " + tempArray[0] + " Activity: " + tempArray[1];
                    evaluationsForToday.add(item);
                  }
                });
                setState(() {
                //  _tasksChosen = events;
                  _tasksChosen = evaluationsForToday;
                });
              },
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(
                 // fontWeight: FontWeight.bold,
                ),
                weekendStyle: TextStyle(
                  color: Colors.cyanAccent.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
              calendarStyle: CalendarStyle(
                  canEventMarkersOverflow: true,
                  todayColor: Colors.amber,
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
                  selectedColor: Colors.blue.shade900,
                  markersMaxAmount: 3,
                  markersColor: Colors.cyanAccent,
                  cellMargin: EdgeInsets.all(5),
                  todayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                      color: Colors.white),
              ),
              calendarController: _calendarController,
            ),
            ..._tasksChosen.map((event) => Padding(
                  padding: const EdgeInsets.all(5.0),
                    child: Column(
                      children: [
                        Card(
                          shadowColor: Colors.black,
                          elevation: 6,
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24),
                          ),

                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: ListTile(
                                  title: Text(
                                    event,
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  /*leading: IconButton(
                                    icon: Icon(
                                      Icons.clear,
                                      color: Colors.red,
                                    ),
                                    onPressed: (){

                                      setState(() {
                                        _tasks[_calendarController.selectedDay]
                                            .remove(event);
                                        prefs.setString("events", json.encode(encodeMap(_tasks)));
                                        _taskController.clear();
                                      });
                                    },
                                  ),*/
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

                )),

          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        child: Icon(
          Icons.add,
        ),
        onPressed: _addTaskDialog,
      ),
    );
  }

  _addTaskDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              title: Text("Add a new task or event"),
              content: TextField(
              /*  decoration: InputDecoration(
                  hintText: 'Title'
                ),*/
                controller: _taskController,
              ),
              actions: <Widget>[
                FlatButton(
                  child: Text(
                    "ADD",
                    style: TextStyle(
                        color: Colors.pinkAccent, fontWeight: FontWeight.bold),
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
                      prefs.setString("events", json.encode(encodeMap(_tasks)));
                      _taskController.clear();
                      Navigator.pop(context);
                    });
                  },
                )
              ],
            ));
  }
}
