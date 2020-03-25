import 'package:charts_flutter/flutter.dart' as charts;
import 'package:corona/Widgets/statChart.dart';
import 'package:flutter/material.dart';

class DoubleChart extends StatelessWidget {
  //List of Data for the Chart set over constructor
  //Time Series Cases is defined in other Chart Class
  final List<TimeSeriesCases> data1;
  final List<TimeSeriesCases> data2;

  //Color for the Chart set via Constructor
  final charts.Color color1;
  final charts.Color color2;
  //Constructor
  DoubleChart(
      {@required this.data1,
      @required this.data2,
      @required this.color1,
      @required this.color2});

  @override
  Widget build(BuildContext context) {
    List<charts.Series<TimeSeriesCases, DateTime>> series = [
      charts.Series(
          id: 'data1',
          colorFn: (_, __) => color1,
          domainFn: (TimeSeriesCases cases, _) => cases.time,
          measureFn: (TimeSeriesCases cases, _) => cases.number,
          data: data1),
      charts.Series(
          id: 'data2',
          colorFn: (_, __) => color2,
          domainFn: (TimeSeriesCases cases, _) => cases.time,
          measureFn: (TimeSeriesCases cases, _) => cases.number,
          data: data2),
    ];
    return Expanded(
      child: charts.TimeSeriesChart(series, animate: false),
    );
  }
}
