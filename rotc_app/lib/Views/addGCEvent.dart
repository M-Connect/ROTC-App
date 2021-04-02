import 'package:flutter/cupertino.dart';
import 'package:googleapis/calendar/v3.dart' as schedule;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rotc_app/app/Schedule/Models/gc_event_model.dart';
import 'package:rotc_app/app/Schedule/ViewModels/gc_event_ops.dart';
import 'package:rotc_app/services/gc_event_crud.dart';

class AddGCEvent extends StatefulWidget {
  @override
  _AddGCEventState createState() => _AddGCEventState();
}

class _AddGCEventState extends State<AddGCEvent> {
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

  _setDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: dateChosen,
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
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
        return 'Title can\'t be empty';
      }
    } else {
      return 'Title can\'t be empty';
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
      return 'Can\'t add an empty email';
    }

    return 'Invalid email';
  }

  @override
  void initState() {
    dateController = TextEditingController();
    startTimeController = TextEditingController();
    endTimeController = TextEditingController();
    titleController = TextEditingController();
    detailsController = TextEditingController();
    locationController = TextEditingController();
    userController = TextEditingController();

    titleFNode = FocusNode();
    detailsFNode = FocusNode();
    locationFNode = FocusNode();
    userFNode = FocusNode();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event to Google Calendar'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_sharp),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
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
                SizedBox(height: 8.0),
                TextFormField(
                  controller: titleController,
                  focusNode: titleFNode,
                  textInputAction: TextInputAction.next,
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
                        isModifyingTitle ? _validateTitle(titleGiven) : null,
                    errorStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 16.0),
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
                  onChanged: (value) {
                    setState(() {
                      detailsGiven = value;
                    });
                  },
                  onFieldSubmitted: (value){
                    detailsFNode.unfocus();
                    FocusScope.of(context).requestFocus(locationFNode);
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
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 16.0),
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
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 16.0),
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
                SizedBox(height: 8.0),
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
                          fontWeight: FontWeight.bold,
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
      contentPadding: EdgeInsets.only(
        left: 16,
        bottom: 16,
        top: 16,
        right: 16,
      ),
      hintText: 'johndoe@rotc.com',
      hintStyle: TextStyle(
        color: Colors.grey.withOpacity(0.6),
        fontWeight: FontWeight.bold,
        letterSpacing: 0.5,
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
                            'Send Email',
                            style: TextStyle(
                              color: Colors.indigo.shade700,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
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
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 16.0),
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
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 16.0),
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
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 16.0),
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
                SizedBox(height: 16.0),
                Divider(),
                SizedBox(height: 20.0),
                Container(
                  //width: double.maxFinite,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      OutlinedButton(
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
                                await eventOps.insert(
                                    title: titleGiven,
                                    details: detailsGiven ?? '',
                                    location: locationGiven,
                                    userEmails: users,
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

                                  await eventCRUD.createGCEvent(eventInfo)
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
                                errorText = 'Times aren\'t proabable';
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
                        child: Padding(
                          padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: isDataWriting ? SizedBox(
                            height: 28,
                            width: 28,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                              : Text(
                            'ADD EVENT ',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: Colors.purpleAccent,
                            ),
                          ),
                        ),
                      ),
                    ],
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
        ),
      ),
    );
  }
}
