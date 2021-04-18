import 'package:flutter/cupertino.dart';
import 'package:googleapis/calendar/v3.dart' as schedule;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rotc_app/app/Schedule/Models/gc_event_model.dart';
import 'package:rotc_app/app/Schedule/ViewModels/gc_event_ops.dart';
import 'package:rotc_app/services/gc_event_crud.dart';

// Author: Christine Thomas
// Revised: 4/13/21

class UpdateGCEvent extends StatefulWidget {

  final GCEventModel event;
  UpdateGCEvent({this.event});

  @override
  _UpdateGCEventState createState() => _UpdateGCEventState();
}

class _UpdateGCEventState extends State<UpdateGCEvent> {
  GCEventCRUD eventCRUD = GCEventCRUD();
  GCEventOps eventOps = GCEventOps();

  TextEditingController dateController;
  TextEditingController startTimeController;
  TextEditingController endTimeController;
  TextEditingController titleController;
  TextEditingController detailsController;
  TextEditingController locationController;
  TextEditingController userController;

  FocusNode titleFNode;
  FocusNode detailsFNode;
  FocusNode locationFNode;
  FocusNode userFNode;

  DateTime dateChosen = DateTime.now();
  TimeOfDay startTimeChosen = TimeOfDay.now();
  TimeOfDay endTimeChosen = TimeOfDay.now();

  String eventId;
  String titleGiven;
  String detailsGiven;
  String locationGiven;
  String emailGiven;
  String errorText = '';
  List<schedule.EventAttendee> users = [];

  bool isModifyingTitle = false;
  bool isModifyingDetails = false;
  bool isModifyingDateStartTime = false;
  bool isModifyingDateEndTime = false;
  bool isModifyingDate = false;
  bool isModifyingEmail = false;
  bool isModifyingBatch = false;
  bool sendNotification = false;
  bool isErrorTime = false;
  bool isDataWriting = false;
  bool isDeletingEvent = false;

  _setDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: dateChosen,
      firstDate: DateTime(2020),
      lastDate: DateTime(2077),
    );
    if (picked != null && picked != dateChosen) {
      setState(() {
        dateChosen = picked;
        dateController.text = DateFormat.yMMMMd().format(dateChosen);
      });
    }
  }

  _selectStartTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: startTimeChosen,
    );
    if (picked != null && picked != startTimeChosen) {
      setState(() {
        startTimeChosen = picked;
        startTimeController.text = startTimeChosen.format(context);
      });
    } else {
      setState(() {
        startTimeController.text = startTimeChosen.format(context);
      });
    }
  }

  _selectEndTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: endTimeChosen,
    );
    if (picked != null && picked != endTimeChosen) {
      setState(() {
        endTimeChosen = picked;
        endTimeController.text = endTimeChosen.format(context);
      });
    } else {
      setState(() {
        endTimeController.text = endTimeChosen.format(context);
      });
    }
  }

  String _validateTitle(String value) {
    if (value != null) {
      value = value?.trim();
      if (value.isEmpty) {
        return 'Title cannot be empty';
      }
    } else {
      return 'Title cannot be empty';
    }

    return null;
  }

  String _validateEmail(String value) {
    if (value != null) {
      value = value.trim();

      if (value.isEmpty) {
        return 'Can\'t add an empty email';
      } else {
        final regex = RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
        final matches = regex.allMatches(value);
        for (Match match in matches) {
          if (match.start == 0 && match.end == value.length) {
            return null;
          }
        }
      }
    } else {
      return 'Email is required.';
    }

    return 'Invalid email';
  }

  @override
  void initState() {
    super.initState();
    DateTime sTime = DateTime.fromMillisecondsSinceEpoch(widget.event.startTime);
    DateTime eTime = DateTime.fromMillisecondsSinceEpoch(widget.event.endTime);
    startTimeChosen = TimeOfDay.fromDateTime(sTime);
    endTimeChosen = TimeOfDay.fromDateTime(eTime);
    titleGiven = widget.event.title;
    detailsGiven = widget.event.details;
    locationGiven = widget.event.location;
    eventId = widget.event.id;


   /* widget.event.userEmails.forEach((element) {
      schedule.EventAttendee relevantUser = schedule.EventAttendee();
      relevantUser.email = element;
      users.add(relevantUser);
    });*/

    String dateString = DateFormat.yMMMMd().format(sTime);
    String startString = DateFormat.jm().format(sTime);
    String endString = DateFormat.jm().format(eTime);
    dateController = TextEditingController(text: dateString);
    startTimeController = TextEditingController(text: startString);
    endTimeController = TextEditingController(text: endString);
    titleController = TextEditingController(text: titleGiven);
    detailsController = TextEditingController(text: detailsGiven);
    locationController = TextEditingController(text: locationGiven);
    userController = TextEditingController();

    titleFNode = FocusNode();
    detailsFNode = FocusNode();
    locationFNode = FocusNode();
    userFNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Google Calendar Event'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    text: 'Title',
                    style: TextStyle(
                      color: Colors.indigo.shade700,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: titleController,
                  focusNode: titleFNode,
                  onChanged: (value) {
                    setState(() {
                      isModifyingTitle = true;
                      titleGiven = value;
                    });
                  },
                  onFieldSubmitted: (value) {
                    titleFNode.unfocus();
                    FocusScope.of(context).requestFocus(detailsFNode);
                  },
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),

                  /// CHANGE THIS
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.cyan,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    contentPadding: EdgeInsets.all(16.0),
                    errorText:
                    isModifyingTitle ? _validateTitle(titleGiven) : null,
                    errorStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
                ),

                SizedBox(height: 8),

                RichText(
                  text: TextSpan(
                    text: 'Details',
                    style: TextStyle(
                      color: Colors.indigo.shade700,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: detailsController,
                  focusNode: detailsFNode,
                  //maxLines: 10,
                  onChanged: (value) {
                    setState(() {
                      detailsGiven = value;
                    });
                  },
                  onFieldSubmitted: (value) {
                    detailsFNode.unfocus();
                    FocusScope.of(context).requestFocus(locationFNode);
                  },
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),

                  /// CHANGE THIS
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.cyan,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    contentPadding: EdgeInsets.only(
                      left: 16,
                      bottom: 16,
                      top: 16,
                      right: 16,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    text: 'Location',
                    style: TextStyle(
                      color: Colors.indigo.shade700,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: locationController,
                  focusNode: locationFNode,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    setState(() {
                      locationGiven = value;
                    });
                  },
                  onFieldSubmitted: (value) {
                    locationFNode.unfocus();
                    FocusScope.of(context).requestFocus(userFNode);
                  },
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.cyan,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    contentPadding: EdgeInsets.only(
                      left: 16,
                      bottom: 16,
                      top: 16,
                      right: 16,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    text: 'Relevant Users',
                    style: TextStyle(
                      color: Colors.indigo.shade700,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                ListView.builder(
                  shrinkWrap: true,
                  physics: PageScrollPhysics(),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            users[index].email,
                            style: TextStyle(
                              color: Colors.cyan,
                              fontSize: 16,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () {
                              setState(() {
                                users.removeAt(index);
                              });
                            },
                            color: Colors.red,
                          ),
                        ],
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: TextField(
                        controller: userController,
                        focusNode: userFNode,
                        textCapitalization: TextCapitalization.none,
                        textInputAction: TextInputAction.done,
                        onChanged: (value) {
                          setState(() {
                            emailGiven = value;
                          });
                        },
                        onSubmitted: (value) {
                          userFNode.unfocus();
                        },
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: new InputDecoration(
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            borderSide: BorderSide(
                              color: Colors.cyan,
                            ),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                            borderSide: BorderSide(
                              color: Colors.red,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          contentPadding: EdgeInsets.all(16),
                          hintText: 'johndoe@rotc.com',
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                          ),
                          errorText: isModifyingEmail ? _validateEmail(emailGiven) : null,
                          errorStyle: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.check,
                        color: Colors.grey,
                        size: 30,
                      ),
                      onPressed: () {
                        setState(() {
                          isModifyingEmail = true;
                        });
                        if (_validateEmail(emailGiven) == null) {
                          setState(() {
                            userFNode.unfocus();
                            schedule.EventAttendee eventAttendee = schedule.EventAttendee();
                            eventAttendee.email = emailGiven;

                            users.add(eventAttendee);

                            userController.text = '';
                            emailGiven = null;
                            isModifyingEmail = false;
                          });
                        }
                      },
                    ),
                  ],
                ),
                Visibility(
                  visible: users.isNotEmpty,
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Notify users',
                            style: TextStyle(
                              color: Colors.indigo.shade700,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Switch(
                            value: sendNotification,
                            onChanged: (value) {
                              setState(() {
                                sendNotification = value;
                              });
                            },
                            activeColor: Colors.purpleAccent,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    text: 'Set Date',
                    style: TextStyle(
                      color: Colors.indigo.shade700,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: dateController,
                  textCapitalization: TextCapitalization.characters,
                  onTap: () => _setDate(context),
                  readOnly: true,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.cyan,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    contentPadding: EdgeInsets.only(
                      left: 16,
                      bottom: 16,
                      top: 16,
                      right: 16,
                    ),
                    errorText: isModifyingDate && DatePickerMode.values != null
                        ? dateController.text.isNotEmpty
                        ? null
                        : 'Date is required'
                        : null,
                    errorStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    text: 'Start Time',
                    style: TextStyle(
                      color: Colors.indigo.shade700,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: startTimeController,
                  onTap: () => _selectStartTime(context),
                  readOnly: true,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.cyan,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    contentPadding: EdgeInsets.only(
                      left: 16,
                      bottom: 16,
                      top: 16,
                      right: 16,
                    ),
                    errorText: isModifyingDateStartTime &&
                        startTimeController.text != null
                        ? startTimeController.text.isNotEmpty
                        ? null
                        : 'Start time required.'
                        : null,
                    errorStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                RichText(
                  text: TextSpan(
                    text: 'End Time',
                    style: TextStyle(
                      color: Colors.indigo.shade700,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: ' *',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8),
                TextFormField(
                  controller: endTimeController,
                  onTap: () => _selectEndTime(context),
                  readOnly: true,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                  decoration: new InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.cyan,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    contentPadding: EdgeInsets.only(
                      left: 16,
                      bottom: 16,
                      top: 16,
                      right: 16,
                    ),
                    errorText:
                    isModifyingDateEndTime && endTimeController.text != null
                        ? endTimeController.text.isNotEmpty
                        ? null
                        : 'End time required.'
                        : null,
                    errorStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(height: 30),
                Container(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        OutlinedButton(
                          onPressed: isDeletingEvent
                              ? null : () async {
                            setState(() {
                              isDeletingEvent = true;
                              isDataWriting = true;
                            });
                            await eventOps.delete(eventId, true).whenComplete(() async {
                              await eventCRUD
                                  .deleteGCEvent(id: eventId)
                                  .whenComplete(() => Navigator.of(context).pop())
                                  .catchError((e) => print(e));
                            });
                            setState(() {
                              isDeletingEvent = false;
                              isDataWriting = false;
                            });
                          },
                          child: isDeletingEvent
                              ? SizedBox(
                            height: 28,
                            width: 28,
                          )
                              : Text(
                            'DELETE',
                            style: TextStyle(
                              color: Colors.redAccent,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 50,
                    ),
                    child: OutlinedButton(
                      onPressed: isDataWriting ? null : () async {
                        setState(() {
                          isErrorTime = false;
                          isDataWriting = true;
                        });

                        titleFNode.unfocus();
                        detailsFNode.unfocus();
                        locationFNode.unfocus();
                        userFNode.unfocus();

                        if (dateChosen != null &&
                            startTimeChosen != null &&
                            endTimeChosen != null &&
                            titleGiven != null) {
                          int epochStartTime = DateTime(
                            dateChosen.year,
                            dateChosen.month,
                            dateChosen.day,
                            startTimeChosen.hour,
                            startTimeChosen.minute,
                          ).millisecondsSinceEpoch;

                          int epochEndTime = DateTime(
                            dateChosen.year,
                            dateChosen.month,
                            dateChosen.day,
                            endTimeChosen.hour,
                            endTimeChosen.minute,
                          ).millisecondsSinceEpoch;


                          if (epochEndTime - epochStartTime > 0) {
                            if (_validateTitle(titleGiven) == null) {
                              await eventOps.update(
                                  id: eventId,
                                  title: titleGiven,
                                  details: detailsGiven ?? '',
                                  location: locationGiven ?? '',
                                  userEmails: users ?? '',
                                  shouldNotifyAttendees: sendNotification,
                                  startTime: DateTime.fromMillisecondsSinceEpoch(epochStartTime),
                                  endTime: DateTime.fromMillisecondsSinceEpoch(epochEndTime))
                                  .then((eventData) async {
                                String eventId = eventData['id'];

                                List<String> emails = [];

                                for (int i = 0; i < users.length; i++)
                                  emails.add(users[i].email);

                                GCEventModel eventInfo = GCEventModel(
                                  id: eventId,
                                  title: titleGiven,
                                  details: detailsGiven ?? '',
                                  location: locationGiven,
                                  userEmails: emails,
                                  shouldNotifyUsers: sendNotification,
                                  startTime: epochStartTime,
                                  endTime: epochEndTime,
                                );

                                await eventCRUD.updateGCEvent(eventInfo)
                                    .whenComplete(() => Navigator.of(context).pop())
                                    .catchError(
                                      (e) => print(e),
                                );
                              }).catchError(
                                    (e) => print(e),
                              );

                              setState(() {
                                isDataWriting = false;
                              });
                            } else {
                              setState(() {
                                isModifyingTitle = true;

                              });
                            }
                          } else {
                            setState(() {
                              isErrorTime = true;
                              errorText = 'Times aren\'t probable';
                            });
                          }
                        } else {
                          setState(() {
                            isModifyingDate = true;
                            isModifyingDateStartTime = true;
                            isModifyingDateEndTime = true;
                            isModifyingBatch = true;
                            isModifyingTitle = true;
                          });
                        }
                        setState(() {
                          isDataWriting = false;
                        });
                      },
                        child: isDataWriting ? SizedBox(
                          height: 28,
                          width: 28,
                        )
                            : Text(
                          'SUBMIT EDITS ',
                          style: TextStyle(
                            fontSize: 22,
                            color: Colors.purpleAccent,
                          ),
                        ),
                      ),
                  ),

                Visibility(
                  visible: isErrorTime,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        errorText,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 30),
              ],
            ),
      ),
      ],
    ),
          ),
        ),
      ),
    );
  }
}
