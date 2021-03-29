/*
//import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rotc_app/app/peerReview/graphs/graphTitleData.dart';

class LineGraph extends StatefulWidget {
  @override
  _LineGraphState createState() => _LineGraphState();
}

class _LineGraphState extends State<LineGraph> {

  final List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
  @override
  Widget build(BuildContext context) {
    */
/* SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);*//*

    return */
/*Scaffold(

      backgroundColor: Colors.white,
      extendBody: true,

      body:*//*

       */
/* LineChart(

      LineChartData(

          minX: 0,
          minY: 0,
          maxY: 100,
          titlesData: LineTitle.getTitleData(),
          gridData: FlGridData(
            show: true,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: const Color(0xff23b6e6),
                strokeWidth: 1,
                //dashArray: [5, 10],
              );
            },
            drawVerticalLine: true,
            getDrawingVerticalLine: (value) {
              return FlLine(
                color: const Color(0xff23b6e6),
                strokeWidth: 1,
                //dashArray: [10, 10],
              );
            },
          ),
        *//*
*/
/*  borderData: FlBorderData(
            show: true,
            border: Border.all(color: const Color(0xff37434d), width: 1),
          ),
          lineBarsData: [
            LineChartBarData(
                spots: [
                  FlSpot(0, 50),
                  FlSpot(2, 60),
                  FlSpot(5, 30),
                  FlSpot(8, 30),
                ],*//*
*/
/*
                isCurved: true,
                preventCurveOverShooting: true,

                colors: gradientColors,
                barWidth: 5,

                //to have the graph show the dots
             //   dotData: FlDotData(
                  show: true,
                ),

           //     belowBarData: BarAreaData(
                  show: true,
                  colors: gradientColors
                      .map((color) => color.withOpacity(0.3))
                      .toList(),
                )
    //),
          ]),
    );*//*

    // );
  //}
//}
*/
