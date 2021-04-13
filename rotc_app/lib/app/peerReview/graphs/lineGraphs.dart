import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
//import 'package:rotc_app/app/peerReview/lllab2FT/confirmation.dart';
import 'package:rotc_app/app/profile/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../main.dart';

class LineGraph extends StatefulWidget {
  @override
  _LineGraphState createState() => _LineGraphState();
}

class _LineGraphState extends State<LineGraph> {

  List<double> sectionData = [10.0, 10.0, 10.0, 10.0, 10.0];
  int lineIndex;

  String evaluationId = "6p0Bjgwhe06rXhzQGuXM";

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
  void initState(){
    getEvaluationData(evaluationId);
    super.initState();
  }

  CollectionReference evaluation =
  FirebaseFirestore.instance.collection('peerEvaluation');

  getEvaluationData(String evaluationId) async {
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
      }
    }
    );
    setState(() {
      populateSectionData();
    }
    );
  }

  populateSectionData(){
    sectionData[0] = leadershipValue;
    sectionData[1] = executionValue;
    sectionData[2] = planningValue;
    sectionData[3] = communicationValue;
    sectionData[4] = debriefValue;
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            navigation.currentState.pushNamed('/homePage');
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
          margin: EdgeInsets.all(10.0),
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Performance Evaluation Data',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                'Current Progress:',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 25,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: LineChart(
                    mainData(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }


  /*
  LINE GRAPH DOWN BELOW ;)
   */




  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.white60,
            strokeWidth: 1,
          );
        },
        getDrawingVerticalLine: (value) {
          return FlLine(
            color: Colors.white60,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          getTextStyles: (value) =>
          const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                activity;
            break;
              case 1:
                return 'Activity 2';
              case 2:
                return 'Activity 3';
              case 3:
                return 'Activity 4';
              case 4:
                return 'Activity 5';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '0';
              case 10:
                return '10';
              case 20:
                return '20';
              case 30:
                return '30';
              case 40:
                return '40';
              case 50:
                return '50';
              case 60:
                return '60';
              case 70:
                return '70';
              case 80:
                return '80';
              case 90:
                return '90';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData:
      FlBorderData(show: true, border: Border.all(color: Colors.white60, width: 1)),
      minX: 0,
      maxX: 4,
      minY: 0,
      maxY: 90,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, evaluationScore = debriefValue + communicationValue + executionValue + leadershipValue + planningValue),
            FlSpot(1, 30),
            FlSpot(2, 40),
            FlSpot(3, 25),
            FlSpot(4, 80),
          ],
          isCurved: true,
          //colors: gradientColors,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            //colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}



