import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../main.dart';


class Evaluation {
  String evaluationId;
  String activity;
  DateTime evaluationDate;
  double totalScore;
  String userName;

  Evaluation(String evaluationId, String activity, DateTime evaluationDate,
      double totalScore, String userName) {
    this.evaluationId = evaluationId;
    this.activity = activity;
    this.evaluationDate = evaluationDate;
    this.totalScore = totalScore;
    this.userName = userName;
  }
}

class LineGraph extends StatefulWidget {
  @override
  _LineGraphState createState() => _LineGraphState();
}

class _LineGraphState extends State<LineGraph> {
  var evaluationList = new List<Evaluation>();

  SharedPreferences prefs;
  String firstName = "";
  String lastName = "";
  String uid = "";

  List<FlSpot> spots = [
    new FlSpot(0, 0),
    new FlSpot(1, 0),
    new FlSpot(2, 0),
    new FlSpot(3, 0),
    new FlSpot(4, 0),
  ];

  @override
  void initState() {
    super.initState();
    initSharedPreferences();
    getUserToEvaluateData();
    getEvaluationInfo();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
    ]);
  }

  CollectionReference evaluation =
      FirebaseFirestore.instance.collection('peerEvaluation');

  initSharedPreferences() async{
    prefs = await SharedPreferences.getInstance();
  }
  getUserToEvaluateData() async {

    var currentUser = await FirebaseAuth.instance.currentUser;

    setState(() {
      uid = currentUser.uid;
      firstName = prefs.getString('firstName');
      lastName = prefs.getString('lastName');
    });
  }

  getEvaluationInfo() async {
    var data = await FirebaseFirestore.instance
        .collection('peerEvaluation')
        .get()
        .then((docSnapshot) {
      docSnapshot.docs.forEach((element) {
        var userName = firstName + " " + lastName;
        var evalFirstName = element.data()['firstName'].toString();
        var evalLastName = element.data()['lastName'].toString();

        if (evalFirstName == firstName && evalLastName == lastName) {
          var activity = element.data()["activity"] ?? " ";
          var evaluationDate = element.data()["evaluationDate"] ?? " ";
          var debriefValue = element.data()["debriefValue"] ?? "10";
          var communicationValue = element.data()["communicationValue"] ?? "10";
          var executionValue = element.data()["executionValue"] ?? "10";
          var leadershipValue = element.data()["leadershipValue"] ?? "10";
          var planningValue = element.data()["planningValue"] ?? "10";
          double dValue = double.parse(debriefValue);
          double cValue = double.parse(communicationValue);
          double eValue = double.parse(executionValue);
          double lValue = double.parse(leadershipValue);
          double pValue = double.parse(planningValue);
          var evaluationId = element.id;
          var totalScore = dValue + cValue + eValue + lValue + pValue;
          var evalDate = DateTime.parse(evaluationDate);
          var eval = new Evaluation(
              evaluationId, activity, evalDate, totalScore, userName);
          evaluationList.add(eval);
        }
      });
    });
    evaluationList.sort((a, b) => a.evaluationDate.compareTo(b.evaluationDate));
    await createSpots();
    setState(() {});
  }

  createSpots() {
    var evalsToUse = evaluationList.take(5).toList();

    if (evalsToUse.length != 0) {
      spots.clear();

      for (int i = 0; i < evalsToUse.length; i++) {
        var spot =
            new FlSpot(double.parse(i.toString()), evalsToUse[i].totalScore);

        spots.add(spot);
      }
    }
  }

  getTitleOfActivity(int i) {
    if (i < evaluationList.length) {
      return evaluationList.elementAt(i).activity;
    }
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            navigation.currentState.pushNamed('/homePage');
          },
        ),
        title: Text('Line Graph View'),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.logout),
            onPressed: () {},
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
                    myLineChart(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  //LINE GRAPH DOWN BELOW ;)

  LineChartData myLineChart() {
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
          getTextStyles: (value) => const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
          getTitles: (value) {

            switch (value.toInt()) {
              case 0:
                return getTitleOfActivity(0);
              case 1:
                return getTitleOfActivity(1);
              case 2:
                return getTitleOfActivity(2);
              case 3:
                return getTitleOfActivity(3);
              case 4:
                return getTitleOfActivity(4);
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
              case 100:
                return '100';
            }
            return '';
          },
          reservedSize: 28,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: true, border: Border.all(color: Colors.white60, width: 1)),
      minX: 0,
      maxX: 4,
      minY: 0,
      maxY: 100,
      lineTouchData: LineTouchData(
        enabled: true,
        fullHeightTouchLine: false,
        handleBuiltInTouches: true,
        touchCallback: (LineTouchResponse touchResponse) async {
          var l = touchResponse.lineBarSpots;

          if (l.isNotEmpty) {
            var selectedIndex = l.first.spotIndex;
            var evalId = this.evaluationList[selectedIndex].evaluationId;
            prefs.setString('barChartEvalId', evalId);
            navigation.currentState.pushNamed('/barGraph');
          }
        },
        getTouchedSpotIndicator:
            (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((spotIndex) {
            final FlSpot spot = barData.spots[spotIndex];
            if (spot.x == 0 || spot.x == 30 || spot.x == 29) {
              return null;
            }
            return TouchedSpotIndicatorData(
              FlLine(color: Colors.transparent, strokeWidth: 0),
              FlDotData(show: true),
            );
          }).toList();
        },
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Colors.white,
          fitInsideHorizontally: true,
          fitInsideVertically: true,
          getTooltipItems: (List<LineBarSpot> touchedBarSpots) {
            return touchedBarSpots.map((barSpot) {
              final flSpot = barSpot;

              return LineTooltipItem(
                '${flSpot.y}',
                const TextStyle(
                    color: Colors.black87,
                    fontFamily: 'NeueMontreal',
                    letterSpacing: 0.9,
                    fontWeight: FontWeight.w600,
                    fontSize: 12),
              );
            }).toList();
          },
        ),
      ),
      lineBarsData: [
        LineChartBarData(
          spots: this.spots,
          isCurved: false,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
          ),
        ),
      ],
    );
  }
}
