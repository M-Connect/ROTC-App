import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class BarGraphv2  extends StatefulWidget {
  @override
  _BarGraphv2State createState() => _BarGraphv2State();
}

class _BarGraphv2State extends State<BarGraphv2 > {
  final List<double> sectionData = [10.0, 17.0, 20.0, 9.0, 5.0];
  int barIndex;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                'LeadLab Week 2',
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
          y: touched && y < 20 ? y + 1 : y,
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

  BarChartData myBarChart() {
    return BarChartData(
      barTouchData: _bgTouchData(),
      titlesData: _bgTitlesData(),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: _bgGroups(),
    );
  }

  BarTouchData _bgTouchData() {
    return BarTouchData(
      touchTooltipData: BarTouchTooltipData(
        tooltipBgColor: Colors.black,
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          String section;
          switch (group.x.toInt()){
            case 0:
              section = 'Leadership:\n \' Demonstrated good leadership skills.\'';
              break;
            case 1:
              section = 'Execution:\n \'Execution left something to be desired.\'';
              break;
            case 2:
              section = 'Planning: \n \'Seemed like they planned really well.\'';
              break;
            case 3:
              section = 'Debrief: \n \'Confused by debrief.\'';
              break;
            case 4:
              section = 'Communication: \n \'Communication wasnt always clear.\'';
              break;
          }
          return BarTooltipItem(section + '\n' + (rod.y).toString() + ' Points', TextStyle(
            color: Colors.white,
          ));
        }
      ),
      touchCallback: (btr) {
        setState(() {
          if(btr.spot != null &&
              btr.touchInput is !FlPanEnd &&
              btr.touchInput is !FlLongPressEnd) {
            barIndex = btr.spot.touchedBarGroupIndex;
          }
          else {
            barIndex = -1;
          }
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
              return 'L';
            case 1:
              return 'E';
            case 2:
              return 'P';
            case 3:
              return 'D';
            case 4:
              return 'C';
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
