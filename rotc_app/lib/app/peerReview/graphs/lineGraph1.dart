import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineGraph1 extends StatefulWidget {
 // const LineGraph({Key? key}) : super(key: key);

  @override
  _LineGraph1State createState() => _LineGraph1State();
}


/*
@override

void initState() {
  super.initState();
  //initSharedPreferences();
  //getUserToEvaluateData();
  //getEvaluationInfo();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
  ]);
}
*/
class _LineGraph1State extends State<LineGraph1> {
  SharedPreferences prefs;
  String firstName = "";
  String lastName = "";
  String uid = "";

  @override
  void initState() {
    super.initState();
    getUserToEvaluateData();
    getEvaluationInfo();
    initSharedPreferences();
  }

  void getEvaluationInfo() {
  }

  Future<void> getUserToEvaluateData() async {
    var currentUser = await FirebaseAuth.instance.currentUser;
    setState(() {
      uid = currentUser.uid;
      firstName = prefs.getString('firstName');
      lastName = prefs.getString('lastName');
    });
  }

  initSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
  }


  @override
  Widget build(BuildContext context) {
    final List<SalesData> chartData = [
      SalesData(0, 0),
      SalesData(3, 5),
      SalesData(4, 7),
      /*SalesData(2011, 28),
      SalesData(2012, 34),
      SalesData(2013, 32),
      SalesData(2014, 40)*/
    ];
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () async {
              Navigator.pop(context);
            },
          ),
        ),

          body: Center(
              child: Container(
                  child: SfCartesianChart(
                      //primaryXAxis: DateTimeAxis(),
                      series: <ChartSeries>[
                        // Renders line chart
                        LineSeries<SalesData, int>(
                            dataSource: chartData,
                            xValueMapper: (SalesData sales, _) => sales.year,
                            yValueMapper: (SalesData sales, _) => sales.sales
                        )
                      ]
                  )
              )
          )

      ),
    );

  }
}
class SalesData {
  SalesData(this.year, this.sales);
  final int year;
  final double sales;
}