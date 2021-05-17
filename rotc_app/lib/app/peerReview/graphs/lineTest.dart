import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class LineTest extends StatefulWidget {
  const LineTest({Key key}) : super(key: key);

  @override
  _LineTestState createState() => _LineTestState();
}

class _LineTestState extends State<LineTest> {
  List<SalesData> _chartData;

  @override
  void initState() {
    _chartData = getChartData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SfCartesianChart(
          title: ChartTitle(
            text: 'Performance Evaluation Data',
          ),
          series: <ChartSeries>[
            LineSeries<SalesData, double>(
                dataSource: _chartData,
                xValueMapper: (SalesData sales, _) => sales.year,
                yValueMapper: (SalesData sales, _) => sales.sales,
                dataLabelSettings: DataLabelSettings(isVisible: true))
          ],
          primaryXAxis:
              NumericAxis(edgeLabelPlacement: EdgeLabelPlacement.shift),
        ),
      ),
    );
  }

  /*
  * this method will get the chart data to be displayed in the chart
  * */
  List<SalesData> getChartData() {
    final List<SalesData> chartData = [
      SalesData(2017, 25),
      SalesData(2018, 12),
      SalesData(2019, 24),
      SalesData(2020, 18),
      SalesData(2021, 30)
    ];
    return chartData;
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final double year;
  final double sales;
}
