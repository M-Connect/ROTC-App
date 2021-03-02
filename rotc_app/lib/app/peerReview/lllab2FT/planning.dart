import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
/*
 Author: Kyle Serruys
  This class is the Planning page of our peer review
 */

class Planning extends StatefulWidget {
  Planning() : super();

  @override
  PlanningState createState() => PlanningState();
}


class PlanningState extends State<Planning> {
  TextEditingController teamOrganization;
  TextEditingController outsidePreparation;
  TextEditingController missionFocus;
  TextEditingController creativity;

  int groupValueA;
  int groupValueB;
  int groupValueC;
  int groupValueD;

  @override
  void initState() {
    super.initState();
    initControllers();
    initRadioButtons();
  }

  initControllers() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var teamOrganizationValue =
      prefs.getString("teamOrganization");
      teamOrganization =
          TextEditingController(text: teamOrganizationValue);

      var outsidePreparationValue = prefs.getString("outsidePreparation");
      outsidePreparation =
          TextEditingController(text: outsidePreparationValue);

      var missionFocusValue = prefs.getString("missionFocus");
      missionFocus =
          TextEditingController(text: missionFocusValue);

      var creativityValue = prefs.getString("creativity");
      creativity =
          TextEditingController(text: creativityValue);
    });
  }

  initRadioButtons() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      var pValueA = prefs.getString("planningValueA");
      var pValueB = prefs.getString("planningValueB");
      var pValueC = prefs.getString("planningValueC");
      var pValueD = prefs.getString("planningValueD");

      if (pValueA != null) {
        buttonChangeA(int.parse(pValueA));
      }
      if (pValueB != null) {
        buttonChangeB(int.parse(pValueB));
      }
      if (pValueC != null) {
        buttonChangeC(int.parse(pValueC));
      }
      if (pValueD != null) {
        buttonChangeD(int.parse(pValueD));
      }
    });
  }

  void buttonChangeA(int button) {
    setState(() {
      if (button == 20) {
        groupValueA = 20;
      } else if (button == 15) {
        groupValueA = 15;
      } else if (button == 10) {
        groupValueA = 10;
      } else if (button == 5) {
        groupValueA = 5;
      } else if (button == 0) {
        groupValueA = 0;
      }
    });
  }

  void buttonChangeB(int button) {
    setState(() {
      if (button == 20) {
        groupValueB = 20;
      } else if (button == 15) {
        groupValueB = 15;
      } else if (button == 10) {
        groupValueB = 10;
      } else if (button == 5) {
        groupValueB = 5;
      } else if (button == 0) {
        groupValueB = 0;
      }
    });
  }

  void buttonChangeC(int button) {
    setState(() {
      if (button == 20) {
        groupValueC = 20;
      } else if (button == 15) {
        groupValueC = 15;
      } else if (button == 10) {
        groupValueC = 10;
      } else if (button == 5) {
        groupValueC = 5;
      } else if (button == 0) {
        groupValueC = 0;
      }
    });
  }
  void buttonChangeD(int button){
    setState(() {
      if (button == 20) {
        groupValueD = 20;
      } else if (button == 15) {
        groupValueD = 15;
      } else if (button == 10) {
        groupValueD = 10;
      } else if (button == 5) {
        groupValueD = 5;
      } else if (button == 0) {
        groupValueD = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
        title: Text('Planning'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
            onPressed: () {

            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25.0),
        child: Center(
          //Team Organization
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Text('Team Organization'),
              ),
              Container(
                child: Row(
                  //  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: 200.0,
                      child: TextFormField(
                        textAlignVertical: TextAlignVertical.top,

                        maxLength: 160,
                        maxLengthEnforced: true,
                        maxLines: 10,
                        controller: teamOrganization,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding:
                              //  const EdgeInsets.symmetric(vertical: 75.0),
                              EdgeInsets.all(10.0),
                        ),
                        onSaved: (teamOrganization) async {

                        },

                        validator: RequiredValidator(
                            errorText: "Team Organization is required."),
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          ListTile(
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              title: const Text('20 pt'),
                              leading: Radio(
                                value: 20,
                                activeColor: Colors.black87,
                                groupValue: groupValueA,
                                onChanged: (int a) => buttonChangeA(a),
                              )),
                          ListTile(
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              title: const Text('15 pt'),
                              leading: Radio(
                                value: 15,
                                activeColor: Colors.black87,
                                groupValue: groupValueA,
                                onChanged: (int a) => buttonChangeA(a),
                              )),
                          ListTile(
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              title: const Text('10 pt'),
                              leading: Radio(
                                value: 10,
                                activeColor: Colors.black87,
                                groupValue: groupValueA,
                                onChanged: (int a) => buttonChangeA(a),
                              )),
                          ListTile(
                              visualDensity:
                                  VisualDensity(horizontal: -4, vertical: -4),
                              title: const Text('5 pt'),
                              leading: Radio(
                                value: 5,
                                activeColor: Colors.black87,
                                groupValue: groupValueA,
                                onChanged: (int a) => buttonChangeA(a),
                              )),
                          ListTile(
                            visualDensity:
                                VisualDensity(horizontal: -4, vertical: -4),
                            title: const Text('0 pt'),
                            leading: Radio(
                              value: 0,
                              activeColor: Colors.black87,
                              groupValue: groupValueA,
                              onChanged: (int a) => buttonChangeA(a),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              //Outside Preparation
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                    child: Text('Outside Preparation'),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          width: 200.0,
                          child: TextFormField(
                            textAlignVertical: TextAlignVertical.top,
                            maxLength: 160,
                            maxLengthEnforced: true,
                            maxLines: 10,
                            controller: outsidePreparation,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              contentPadding:
                                  //   const EdgeInsets.symmetric(vertical: 75.0),
                                  EdgeInsets.all(10.0),
                            ),
                            onSaved: (String value) {},
                            validator: RequiredValidator(
                                errorText: "Outside preparation is required."),
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              ListTile(
                                  visualDensity: VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  title: const Text('20 pt'),
                                  leading: Radio(
                                    value: 20,
                                    activeColor: Colors.black87,
                                    groupValue: groupValueB,
                                    onChanged: (int b) => buttonChangeB(b),
                                  )),
                              ListTile(
                                  visualDensity: VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  title: const Text('15 pt'),
                                  leading: Radio(
                                    value: 15,
                                    activeColor: Colors.black87,
                                    groupValue: groupValueB,
                                    onChanged: (int b) => buttonChangeB(b),
                                  )),
                              ListTile(
                                  visualDensity: VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  title: const Text('10 pt'),
                                  leading: Radio(
                                    value: 10,
                                    activeColor: Colors.black87,
                                    groupValue: groupValueB,
                                    onChanged: (int b) => buttonChangeB(b),
                                  )),
                              ListTile(
                                  visualDensity: VisualDensity(
                                      horizontal: -4, vertical: -4),
                                  title: const Text('5 pt'),
                                  leading: Radio(
                                    value: 5,
                                    activeColor: Colors.black87,
                                    groupValue: groupValueB,
                                    onChanged: (int b) => buttonChangeB(b),
                                  )),
                              ListTile(
                                visualDensity:
                                    VisualDensity(horizontal: -4, vertical: -4),
                                title: const Text('0 pt'),
                                leading: Radio(
                                  value: 0,
                                  activeColor: Colors.black87,
                                  groupValue: groupValueB,
                                  onChanged: (int b) => buttonChangeB(b),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Mission Focus
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                        child: Text('Mission Focus'),
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: 200.0,
                              child: TextFormField(
                                textAlignVertical: TextAlignVertical.top,
                                maxLength: 160,
                                maxLengthEnforced: true,
                                maxLines: 10,
                                controller: missionFocus,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  contentPadding:
                                      //const EdgeInsets.symmetric(vertical: 75.0),
                                      EdgeInsets.all(10.0),
                                ),
                                onSaved: (String value) {},
                                validator: RequiredValidator(
                                    errorText: "Mission focus is required."),
                              ),
                            ),
                            SizedBox(
                              width: 150,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  ListTile(
                                      visualDensity: VisualDensity(
                                          horizontal: -4, vertical: -4),
                                      title: const Text('20 pt'),
                                      leading: Radio(
                                        value: 20,
                                        activeColor: Colors.black87,
                                        groupValue: groupValueC,
                                        onChanged: (int c) => buttonChangeC(c),
                                      )),
                                  ListTile(
                                      visualDensity: VisualDensity(
                                          horizontal: -4, vertical: -4),
                                      title: const Text('15 pt'),
                                      leading: Radio(
                                        value: 15,
                                        activeColor: Colors.black87,
                                        groupValue: groupValueC,
                                        onChanged: (int c) => buttonChangeC(c),
                                      )),
                                  ListTile(
                                      visualDensity: VisualDensity(
                                          horizontal: -4, vertical: -4),
                                      title: const Text('10 pt'),
                                      leading: Radio(
                                        value: 10,
                                        activeColor: Colors.black87,
                                        groupValue: groupValueC,
                                        onChanged: (int c) => buttonChangeC(c),
                                      )),
                                  ListTile(
                                      visualDensity: VisualDensity(
                                          horizontal: -4, vertical: -4),
                                      title: const Text('5 pt'),
                                      leading: Radio(
                                        value: 5,
                                        activeColor: Colors.black87,
                                        groupValue: groupValueC,
                                        onChanged: (int c) => buttonChangeC(c),
                                      )),
                                  ListTile(
                                    visualDensity: VisualDensity(
                                        horizontal: -4, vertical: -4),
                                    title: const Text('0 pt'),
                                    leading: Radio(
                                      value: 0,
                                      activeColor: Colors.black87,
                                      groupValue: groupValueC,
                                      onChanged: (int c) => buttonChangeC(c),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Creativity
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 10.0, bottom: 10.0),
                            child: Text('Creativity'),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 200.0,
                                  child: TextFormField(
                                    textAlignVertical: TextAlignVertical.top,
                                    maxLength: 160,
                                    maxLengthEnforced: true,
                                    maxLines: 10,
                                    controller: creativity,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      contentPadding:
                                          //const EdgeInsets.symmetric(vertical: 75.0),
                                          EdgeInsets.all(10.0),
                                    ),
                                    onSaved: (String value) {},
                                    validator: RequiredValidator(
                                        errorText: "Creativity is required."),
                                  ),
                                ),
                                SizedBox(
                                  width: 150,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: <Widget>[
                                      ListTile(
                                        visualDensity: VisualDensity(
                                            horizontal: -4, vertical: -4),
                                        title: const Text('20 pt'),
                                        leading: Radio(
                                          value: 20,
                                          activeColor: Colors.black87,
                                          groupValue: groupValueD,
                                          onChanged: (int d) =>
                                              buttonChangeD(d),
                                        ),
                                      ),
                                      ListTile(
                                        visualDensity: VisualDensity(
                                            horizontal: -4, vertical: -4),
                                        title: const Text('15 pt'),
                                        leading: Radio(
                                          value: 15,
                                          activeColor: Colors.black87,
                                          groupValue: groupValueD,
                                          onChanged: (int d) =>
                                              buttonChangeD(d),
                                        ),
                                      ),
                                      ListTile(
                                        visualDensity: VisualDensity(
                                            horizontal: -4, vertical: -4),
                                        title: const Text('10 pt'),
                                        leading: Radio(
                                          value: 10,
                                          activeColor: Colors.black87,
                                          groupValue: groupValueD,
                                          onChanged: (int d) =>
                                              buttonChangeD(d),
                                        ),
                                      ),
                                      ListTile(
                                          visualDensity: VisualDensity(
                                              horizontal: -4, vertical: -4),
                                          title: const Text('5 pt'),
                                          leading: Radio(
                                            value: 5,
                                            activeColor: Colors.black87,
                                            groupValue: groupValueD,
                                            onChanged: (int d) =>
                                                buttonChangeD(d),
                                          )),
                                      ListTile(
                                        visualDensity: VisualDensity(
                                            horizontal: -4, vertical: -4),
                                        title: const Text('0 pt'),
                                        leading: Radio(
                                          value: 0,
                                          activeColor: Colors.black87,
                                          groupValue: groupValueD,
                                          onChanged: (int d) =>
                                              buttonChangeD(d),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
            EdgeInsets.only(bottom: 40.0, left: 10.0, top: 40.0, right: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Opacity(
              opacity: 0.0,
              child: ElevatedButton(
                child: Text('Prev'),
                onPressed: () async {},
              ),
            ),
            ElevatedButton(
              child: Text('Save'),
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setString('teamOrganization', teamOrganization.text);
                prefs.setString('outsidePreparation', outsidePreparation.text);
                prefs.setString('missionFocus', missionFocus.text);
                prefs.setString('creativity', creativity.text);
                prefs.setString('planningValueA', groupValueA.toString());
                prefs.setString('planningValueB', groupValueB.toString());
                prefs.setString('planningValueC', groupValueC.toString());
                prefs.setString('planningValueD', groupValueD.toString());
                saveNotification(context);
              },
            ),
            ElevatedButton(
              child: Text('Next'),
              onPressed: () async {
                navigation.currentState.pushNamed('/communication');

              },
            ),
          ],
        ),
      ),
    );
  }
}


saveNotification(BuildContext context) {
  Widget button = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  AlertDialog alert = AlertDialog(
    //  title: Text("Saved"),
    content: Text("Input is saved"),
    actions: [
      button,
    ],
  );
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}