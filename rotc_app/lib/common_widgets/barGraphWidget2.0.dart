
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class BarGraphv2  extends StatefulWidget {
  @override
  _BarGraphv2State createState() => _BarGraphv2State();
}

class _BarGraphv2State extends State<BarGraphv2 > {

  List<double> sectionData = [10.0, 10.0, 10.0, 10.0, 10.0];
  int barIndex;

  String evaluationId;// = "6p0Bjgwhe06rXhzQGuXM";

  String evalSection = "";
  String evaluationNotes = "";
  String activity = "";

  double debriefValue = 10.0 ;
  double communicationValue = 10.0;
  double executionValue = 10.0;
  double leadershipValue = 10.0;
  double planningValue = 10.0;
  double evaluationScore = 10.0;



  @override
  void initState() {
    getEvaluationId();
    getEvaluationFromDb();
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      //  DeviceOrientation.landscapeRight,
    ]);
  }

  CollectionReference evaluation =
  FirebaseFirestore.instance.collection('peerEvaluation');

  getEvaluationId()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
setState(() {
   evaluationId = prefs.getString("barChartEvalId");
});

  }

  getEvaluationFromDb()async {

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await evaluation.doc(evaluationId).get().then((DocumentSnapshot documentSnapshot){
      if(documentSnapshot.exists){
        var debrief = documentSnapshot.data()["debrief"]?? " ";
        var debriefValue = documentSnapshot.data()["debriefValue"]?? "10";
        var communication = documentSnapshot.data()["communication"]?? " ";
        var communicationValue = documentSnapshot.data()["communicationValue"]?? "10";
        var execution = documentSnapshot.data()["execution"]?? " ";
        var executionValue = documentSnapshot.data()["executionValue"]?? "10";
        var leadership = documentSnapshot.data()["leadership"]?? " ";
        var leadershipValue = documentSnapshot.data()["leadershipValue"]?? "10";
        var planning = documentSnapshot.data()["planning"]?? " ";
        var planningValue = documentSnapshot.data()["planningValue"]?? "10";
        var activity = documentSnapshot.data()["activity"]?? " ";
        prefs.setString('debrief', debrief);
        prefs.setString('debriefValue', debriefValue);
        prefs.setString('communication', communication);
        prefs.setString('communicationValue', communicationValue);
        prefs.setString('execution', execution);
        prefs.setString('executionValue', executionValue);
        prefs.setString('leadership', leadership);
        prefs.setString('leadershipValue', leadershipValue);
        prefs.setString('planning', planning);
        prefs.setString('planningValue', planningValue);
        prefs.setString('activity', activity);
        this.debriefValue = double.parse(debriefValue);
        this.communicationValue = double.parse(communicationValue);
        this.executionValue = double.parse(executionValue);
        this.leadershipValue = double.parse(leadershipValue);
        this.planningValue = double.parse(planningValue);



/*        debriefValue = double.parse(documentSnapshot.data()["debriefValue"]?? "10");
        communicationValue = double.parse(documentSnapshot.data()["communicationValue"]?? "10");
        executionValue = double.parse(documentSnapshot.data()["executionValue"]?? "10");
        leadershipValue = double.parse(documentSnapshot.data()["leadershipValue"]?? "10");
        planningValue = double.parse(documentSnapshot.data()["planningValue"]?? "10");*/
      }
    });

    setState(() {

      populateSectionData();
    });
  }

  populateSectionData(){
    sectionData[0] = leadershipValue;
    sectionData[1] = executionValue;
    sectionData[2] = planningValue;
    sectionData[3] = communicationValue;
    sectionData[4] = debriefValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            navigation.currentState.pushNamed('/lineGraph');
          },
        ),
        title: Text('Evaluation Confirmation'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Center(
        child: Container(
          height: 500,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Color(0xFF1B949F),
          ),
          margin: EdgeInsets.all(15.0),
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Performance Evaluation Data',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Consolas',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                activity,
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: BarChart(
                    myBarChart(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  BarChartGroupData _bgRods(
      int x,
      double y, {
        bool touched = false,
      }) {
    List<Color> backDrawColor = [Color(0xFF0F4247)];
    List<Color> untouchedColor = [Color(0xFF07DFEE)];
    List<Color> touchedColor = [Color(0xFFF2E360)];

    return BarChartGroupData(
        x: x,
        barRods: [
          BarChartRodData(
            y: y,
            colors: touched ? touchedColor : untouchedColor,
            width: 20,
            backDrawRodData: BackgroundBarChartRodData(
              show: true,
              y: 20,
              colors: backDrawColor,
            ),


          )
        ]
    );
  }


  BarChartData myBarChart(){
    return BarChartData(
      barTouchData: _bgTouchData(),
      titlesData: _bgTitlesData(),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: _bgGroups(),
    );
  }

  BarTouchData _bgTouchData()  {
    return BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.black,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String section;
              switch (group.x.toInt()){
                case 0:
                 // section = 'Leadership:\n \' Demonstrated good leadership skills.\'';
                  evalSection = "/leadershipGraphViewPage";
                  evaluationNotes = "leadership";
                  evaluationScore = leadershipValue;
                  break;
                case 1:
                 // section = 'Execution:\n \'Execution left something to be desired.\'';
                  evalSection = "/executionGraphViewPage";
                  evaluationNotes = "execution";
                  evaluationScore = executionValue;
                  break;
                case 2:
                 // section = 'Planning: \n \'Seemed like they planned really well.\'';
                  evalSection = "/planningGraphViewPage";
                  evaluationNotes = "planning";
                  evaluationScore = planningValue;
                  break;
                case 3:
                 // section = 'Debrief: \n \'Confused by debrief.\'';
                  evalSection = "/debriefGraphViewPage";
                  evaluationNotes = "debrief";
                  evaluationScore = debriefValue;
                  break;
                case 4:
                  //section = "communication";
                  evalSection = "/communicationGraphViewPage";
                  evaluationNotes = "communication";
                  evaluationScore = communicationValue;
                  break;
              }
              return BarTooltipItem(section + '\n' + (rod.y).toString() + ' Points', TextStyle(
                color: Colors.white,
              ));
            }
        ),
        touchCallback: (btr) async {

          setState(() {
            /*if(btr.spot != null &&
                btr.touchInput is !FlPanEnd &&
                btr.touchInput is !FlLongPressEnd) {
              barIndex = btr.spot.touchedBarGroupIndex;*/
              if(evalSection != "") {
                evaluationScore;
                evaluationNotes;
                navigation.currentState.pushNamed(evalSection);
              }
            /*}
            else {
              barIndex = -1;
            }*/
          });
        }
    );
  }

  FlTitlesData _bgTitlesData() {
    return FlTitlesData(
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 30,
          getTextStyles: (value) =>
          const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'Leadership';
              case 1:
                return 'Execution';
              case 2:
                return 'Planning';
              case 3:
                return 'Debrief';
              case 4:
                return 'Communication';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) =>
          const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
          interval: 5,
          getTitles: (double value) => '${value.toInt()}',
          margin: 16,
        )
    );
  }

  List<BarChartGroupData> _bgGroups() {

    return List.generate(sectionData.length, (index) => _bgRods(index, sectionData[index],
        touched: index == barIndex),
    );
  }
}