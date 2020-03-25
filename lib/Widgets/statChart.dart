/// Timeseries chart example
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class StatChart extends StatelessWidget {
  //List of Data for the chart is Set over Constructor
  final List<TimeSeriesCases> currentCases;
  final List<TimeSeriesCases> recovered;
  final List<TimeSeriesCases> deaths;
  //Don't know if neede

  StatChart(
      {@required this.currentCases,
      @required this.recovered,
      @required this.deaths});

  /*
  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory StatChart.withSampleData() {
    return new StatChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
    
  }
*/
  @override
  Widget build(BuildContext context) {
    //Make a List of Charts
    List<charts.Series<TimeSeriesCases, DateTime>> series = [
      //Current Chart
      charts.Series(
          id: 'current',
          colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
          domainFn: (TimeSeriesCases cases, _) => cases.time,
          measureFn: (TimeSeriesCases cases, _) => cases.number,
          data: currentCases),
      //Recovered Chart
      charts.Series(
          id: 'recoverd',
          colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
          domainFn: (TimeSeriesCases cases, _) => cases.time,
          measureFn: (TimeSeriesCases cases, _) => cases.number,
          data: recovered),
      //Deaths Chart
      charts.Series(
          id: 'deaths',
          colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
          domainFn: (TimeSeriesCases cases, _) => cases.time,
          measureFn: (TimeSeriesCases cases, _) => cases.number,
          data: deaths),
    ];

    return charts.TimeSeriesChart(series, animate: false);
  }
}

//!If possible Maybe Move to Asset file
/// Sample time series data type.
class TimeSeriesCases {
  final DateTime time;
  final int number;

  TimeSeriesCases(this.time, this.number);
}
