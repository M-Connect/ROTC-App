import 'package:flutter/cupertino.dart';
import 'package:googleapis/calendar/v3.dart' as schedule;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rotc_app/app/Schedule/Models/gc_event_model.dart';
import 'package:rotc_app/app/Schedule/ViewModels/gc_event_ops.dart';
import 'package:rotc_app/services/gc_event_crud.dart';

/*
Author: Christine Thomas
Updated: 4/17/21
These classes allow for adding Google Calendar Events via a Form for the user
to fill out.
 */
class AddGCEvent extends StatefulWidget {
  @override
  _AddGCEventState createState() => _AddGCEventState();
}

class _AddGCEventState extends State<AddGCEvent> {

  /*
  Creating instances of GCEventCRUD and GCEventOps to be used
   */
  GCEventCRUD eventCRUD = GCEventCRUD();
  GCEventOps eventOps = GCEventOps();

  /*
  Defining the TextEditingControllers for each field
   */
  TextEditingController dateController;
  TextEditingController startTimeController;
  TextEditingController endTimeController;
  TextEditingController titleController;
  TextEditingController detailsController;
  TextEditingController locationController;
  TextEditingController userController;

  /* Defining the focusNodes for each field */

  FocusNode titleFNode;
  FocusNode detailsFNode;
  FocusNode locationFNode;
  FocusNode userFNode;

  /*
  Setting the initial date, start and end time to now.
   */
  DateTime dateChosen = DateTime.now();
  TimeOfDay startTimeChosen = TimeOfDay.now();
  TimeOfDay endTimeChosen = TimeOfDay.now();

  /*
  Initializing the each field, the error text and the list of users relevant to the event.
   */
  String titleGiven;
  String detailsGiven;
  String locationGiven;
  String emailGiven;
  String errorText = '';
  List<schedule.EventAttendee> users = [];

  /*
  Setting each field modification value to false to start with.
   */
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

  /*
  This function sets the date.
  This function takes as a parameter the context of type BuildContext and has an asynchronous body that
  awaits for the user's input in the showDatePicker to be set to the datePicked variable,
  the context is the context parameter passed in, the initial date is the current date,
  the first date year is 2021, the last year is 2077.

  it then checks if the datePicked is not null and the datePicked is not the same as the dateChosen
  which is the current date, DateTime.now(),
  if so the state is set to the dateChosen now being the datePicked and the dateController's text
  is set to the dateChosen but formatted to look like Month Date, Year format.
   */
  _setDate(BuildContext context) async {
    final DateTime datePicked = await showDatePicker(
      context: context,
      initialDate: dateChosen,
      firstDate: DateTime(2021),
      lastDate: DateTime(2077),
    );
    if (datePicked != null && datePicked != dateChosen) {
      setState(() {
        dateChosen = datePicked;
        dateController.text = DateFormat.yMMMMd().format(dateChosen);
      });
    }
  }

  /*
  This function sets the start time.
  This function takes as a parameter the context of type BuildContext and has an asynchronous body that
  awaits the showTimePicker for the user's input and sets the context to the context parameter
  passed in and the initialTime to the startTimeChosen which is the current time.
  it then checks to see if the startTimePicked is not null and not the same as the startTimeChosen
  which is the current time, if these conditions are met the state is set so that the
  startTimeChosen is now the startTimePicked by the user and the startTimeController's text is set
  to the startTimeChosen which is formatted into localized time.
  Else the state is set to the current time and then formatted into localized time.
   */
  _selectStartTime(BuildContext context) async {
    final TimeOfDay startTimePicked = await showTimePicker(
      context: context,
      initialTime: startTimeChosen,
    );
    if (startTimePicked != null && startTimePicked != startTimeChosen) {
      setState(() {
        startTimeChosen = startTimePicked;
        startTimeController.text = startTimeChosen.format(context);
      });
    } else {
      setState(() {
        startTimeController.text = startTimeChosen.format(context);
      });
    }
  }

  /*
  This function takes as a parameter the context of type BuildContext and has an asynchronous body that
  awaits the showTimePicker for the user's input and sets the context to the context parameter
  passed in and the initialTime to the endTimeChosen which is the current time.
  it then checks to see if the startTimePicked is not null and not the same as the endTimeChosen
  which is the current time, if these conditions are met the state is set so that the
  endTimeChosen is now the endTimePicked by the user and the endTimeController's text is set
  to the endTimeChosen which is formatted into localized time.
  Else the state is set to the current time and then formatted into localized time.
   */

  _selectEndTime(BuildContext context) async {
    final TimeOfDay endTimePicked = await showTimePicker(
      context: context,
      initialTime: endTimeChosen,
    );
    if (endTimePicked != null && endTimePicked != endTimeChosen) {
      setState(() {
        endTimeChosen = endTimePicked;
        endTimeController.text = endTimeChosen.format(context);
      });
    } else {
      setState(() {
        endTimeController.text = endTimeChosen.format(context);
      });
    }
  }

  /*
  This function takes as a parameter a value of type String and checks if the value is not null, if this
  condition is met it will again check if it not null and trim it.
  If the value is empty it will return a string saying that the title is required.
  Else if the value is null it will also return a string saying that the title is required.
  Otherwise it will return nothing and the title is valid.
   */
  String _titleValidator(String value) {
    if (value != null) {
      value = value?.trim();
      if (value.isEmpty) {
        return 'Must add a title';
      }
    } else {
      return 'Title is required';
    }

    return null;
  }

  String _userEmailValidator(String value) {
    if (value != null) {
      value = value.trim();

      if (value.isEmpty) {
        return 'Must add an email.';
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
      return 'Email is required';
    }

    return 'Not a valid email';
  }

  /*
  Initializing the state to of the page to have defined textEditingControllers and FocusNodes.
   */
  @override
  void initState() {
    super.initState();
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
            Text(
              '* indicates a required field.',
              style: TextStyle(
                color: Colors.red,
                fontStyle: FontStyle.italic,
              ),
            ),
                SizedBox(height: 16),
                Form(
                  child: RichText(
                    text: TextSpan(
                      text: 'Title',
                      style: TextStyle(
                        color: Colors.blueAccent,
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
                  /// ONCE THE FIELD IS SUBMITTED UNFOCUS THE NODE AND SEND FOCUS TO THE NEXT ONE.
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
                      borderSide: BorderSide(
                        color: Colors.cyan,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    border: OutlineInputBorder(
                    ),
                    contentPadding: EdgeInsets.all(16.0),
                    hintText: 'Lead Lab',
                    hintStyle: TextStyle(
                      color: Colors.grey,
                    ),
                    errorText:
                        isModifyingTitle ? _titleValidator(titleGiven) : null,
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
                      color: Colors.blueAccent,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                /// SETTING THE CONTROLLER TO THE DETAILSCONTROLLER,
                /// THE FOCUS NODE TO THE DETAILSFOCUSNODE,
                /// AND SETTING THE VALUE OF THE CONTROLLER'S
                /// TEXT TO THE DETAILSGIVEN
                TextFormField(
                  controller: detailsController,
                  focusNode: detailsFNode,
                  onChanged: (value) {
                    setState(() {
                      detailsGiven = value;
                    });
                  },
                  /// ONCE THE FIELD IS SUBMITTED UNFOCUS THE NODE AND SEND FOCUS TO THE NEXT ONE.
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
                      borderSide: BorderSide(
                        color: Colors.cyan,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    border: OutlineInputBorder(
                    ),
                    contentPadding: EdgeInsets.all(16.0),
                    hintText: 'Some information about the Lead Lab',
                    hintStyle: TextStyle(
                      color: Colors.grey,
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
                      color: Colors.blueAccent,
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                SizedBox(height: 8),
                /// SETTING THE CONTROLLER TO THE LOCATIONCONTROLLER,
                /// THE FOCUS NODE TO THE LOCATIONFOCUSNODE,
                /// AND SETTING THE VALUE OF THE CONTROLLER'S
                /// TEXT TO THE LOCATION GIVEN
                TextFormField(
                  controller: locationController,
                  focusNode: locationFNode,
                  textInputAction: TextInputAction.next,
                  onChanged: (value) {
                    setState(() {
                      locationGiven = value;
                    });
                  },
                  /// ONCE THE FIELD IS SUBMITTED UNFOCUS THE NODE AND SEND FOCUS TO THE NEXT ONE.
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
                      borderSide: BorderSide(
                        color: Colors.cyan,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(

                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    border: OutlineInputBorder(
                    ),
                    contentPadding: EdgeInsets.all(16.0),
                    hintText: 'Online',
                    hintStyle: TextStyle(
                      color: Colors.grey,
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
                      color: Colors.blueAccent,
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
              // setting the count to the length of the users array
              itemCount: users.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        /// ACCESSING THE USER LIST AT THE CURRENT INDEX AND DISPLAYING THE EMAIL
                        /// AS  A STRING
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
                          /// IF THE USER HITS THE RED X BUTTON REMOVE THE INPUT AT THE INDEX
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
              /// SET THE CONTROLLER TO THE USERCONTROLLER,
              /// SET THE FOCUSNODE TO THE USERFOCUSNODE,
              /// SET THE VALUE OF THE USERCONTROLLER'S TEXT
              /// TO THE EMAILGIVEN
            controller: userController,
              focusNode: userFNode,
              textCapitalization: TextCapitalization.none,
              textInputAction: TextInputAction.done,
              onChanged: (value) {
                setState(() {
                  emailGiven = value;
                });
              },
              /// ONCE THE FIELD IS SUBMITTED UNFOCUS THE NODE AND SEND FOCUS TO THE NEXT ONE.
              onSubmitted: (value) {
                userFNode.unfocus();
              },
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
    decoration: new InputDecoration(
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
              color: Colors.cyan,
        ),
      ),
      errorBorder: OutlineInputBorder(

        borderSide: BorderSide(
            color: Colors.red,
        ),
      ),
      border: OutlineInputBorder(

      ),
      contentPadding: EdgeInsets.only(
        left: 16,
        bottom: 16,
        top: 16,
        right: 16,
      ),
      hintText: 'johndoe@rotc.com',
      hintStyle: TextStyle(
        color: Colors.grey,
      ),
      errorText: isModifyingEmail ? _userEmailValidator(emailGiven) : null,
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
                    /// EMAIL IS BEING MODIFIED
                    setState(() {
                      isModifyingEmail = true;
                    });
                    /// CHECK TO SEE IF IT IS A VALID EMAIL, IF SO UNFOCUS THE USERFNODE
                    /// AND CREATE AN INSTANCE OF AN EVENT ATTENDEE AND SET THE EVENTATTENDEE'S EMAIL
                    /// TO THE EMAILGIVEN BY THE USER
                    /// ADD THE EVENTATTENDEE TO THE USERS LIST
                    /// RESET THE USERCONTROLLER TEXT TO ''
                    /// EMAILGIVEN IS RESET TO NULL
                    /// AND ISMODIFYING EMAIL IS RESET TO FALSE TO ALLOW FOR ADDING MORE THAN ONE
                    /// RELEVANT USER / EVENT ATTENDEE
                    if (_userEmailValidator(emailGiven) == null) {
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
                /// SHOWN IF THE USER ADDS AN EMAIL TO THE RELEVANT USERS SECTION
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
                              color: Colors.blueAccent,
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
                      color: Colors.blueAccent,
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
                      borderSide: BorderSide(
                        color: Colors.cyan,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    border: OutlineInputBorder(
                    ),
                    contentPadding: EdgeInsets.all(16.0
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
                      color: Colors.blueAccent,
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
                      borderSide: BorderSide(
                        color: Colors.cyan,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    border: OutlineInputBorder(
                    ),
                    contentPadding: EdgeInsets.all (16.0),
                    /// CHECKING TO SEE IF THE STARTTIME IS BEING MODIFIED AND IF IT IS NOT NULL
                    /// OR IF IT IS NOT EMPTY, THEN NOTHING
                    /// ELSE LET THE USER KNOW IT IS REQUIRED
                    /// ELSE NOTHING.
                    errorText: isModifyingDateStartTime &&
                            startTimeController.text != null
                        ? startTimeController.text.isNotEmpty ? null
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
                      color: Colors.blueAccent,
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
                      borderSide: BorderSide(
                        color: Colors.cyan,
                      ),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.red,
                      ),
                    ),
                    border: OutlineInputBorder(
                    ),
                    contentPadding: EdgeInsets.all(16.0),
                    /// CHECKING TO SEE IF THE ENDTIME IS BEING MODIFIED AND IF
                    /// THE ENDTIMECONTROLLER'S TEXT IS NOT NULL
                    /// OR IF IT IS NOT EMPTY, THEN NOTHING
                    /// ELSE LET THE USER KNOW IT IS REQUIRED
                    /// ELSE NOTHING.
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
                        /// IF DATA ISNT WRITING, RETURN NULL
                        /// ELSE SET STATE AS BELOW
                        onPressed: isDataWriting ? null : () async {
                          setState(() {
                            isErrorTime = false;
                            isDataWriting = true;
                          });

                          titleFNode.unfocus();
                          detailsFNode.unfocus();
                          locationFNode.unfocus();
                          userFNode.unfocus();

                          /// IF STATED FIELDS ARE FILLED
                          if (dateChosen != null &&
                              startTimeChosen != null &&
                              endTimeChosen != null &&
                              titleGiven != null) {

                            int epochStartTime = DateTime(
                              dateChosen.year,
                              dateChosen.month,
                              dateChosen.day,
                              startTimeChosen.hour ,
                              startTimeChosen.minute,
                            ).millisecondsSinceEpoch;

                            int epochEndTime = DateTime(
                              dateChosen.year,
                              dateChosen.month,
                              dateChosen.day,
                              endTimeChosen.hour,
                              endTimeChosen.minute,
                            ).millisecondsSinceEpoch;

                            /// IF THE TIME IS VALID AND THE TITLE IS VALID
                            /// SET EVENT MODEL FIELDS AS GIVEN BY USER INPUT
                            /// BY USING THE CREATE METHOD
                            if (epochEndTime - epochStartTime > 0) {
                              if (_titleValidator(titleGiven) == null) {
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

                                  /// ADDING THE USERS EMAIL AT EACH INDEX TO THE EMAILS LIST
                                  for (int index = 0; index < users.length; index++)
                                    emails.add(users[index].email);

                                  GCEventModel eventInfo = GCEventModel(
                                    id: eventId,
                                    title: titleGiven,
                                    details: detailsGiven ?? '',
                                    location: locationGiven ?? '',
                                    userEmails: emails,
                                    shouldNotifyUsers: sendNotification,
                                    startTime: epochStartTime,
                                    endTime: epochEndTime,
                                  );

                                  /// ONCE EVENT HAS SUCCESSFULLY BEEN CREATED IN DATABASE
                                  /// POP CONTEXT
                                  /// OTHERWISE
                                  /// CATCH AND PRINT THE ERROR
                                  await eventCRUD.createGCEvent(eventInfo)
                                      .whenComplete(() => Navigator.of(context).pop())
                                      .catchError(
                                        (error) => print(error),
                                  );
                                }).catchError(
                                      (error) => print(error),
                                );

                                /// RESET ISDATAWRITING TO FALSE ON COMPLETE
                                /// ELSE SET ISMODIFYINGTITLE TO TRUE
                                setState(() {
                                  isDataWriting = false;
                                });
                              } else {
                                setState(() {
                                  isModifyingTitle = true;

                                });
                              }
                            }
                            /// ELSE IF EPOCHENDTIME - EPOCHSTARTTIME IS LESS THAN 0
                            /// TIME ISN'T POSSIBLE
                            else {
                              setState(() {
                                isErrorTime = true;
                                errorText = 'Times aren\'t proabable';
                              });
                            }

                          }
                          /// ELSE IF GIVEN VALUES ARE NULL USER IS MODIFYING
                          else {
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
                         child: Text(
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
