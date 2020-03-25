import 'package:basic_utils/basic_utils.dart';
import 'package:corona/Widgets/statChart.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

import 'doubleChart.dart';

Container makeCompareScreenCard(String headline, List<TimeSeriesCases> data1,
    List<TimeSeriesCases> data2, String country1, String country2) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10), color: Colors.grey[300]),
    padding: const EdgeInsets.only(top: 5),
    child: Column(
      children: <Widget>[
        Text(
          headline,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
        ),
        DoubleChart(
            data1: data1,
            data2: data2,
            color1: charts.MaterialPalette.blue.shadeDefault,
            color2: charts.MaterialPalette.red.shadeDefault),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15, bottom: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                StringUtils.capitalize(country1),
                style: TextStyle(color: Colors.blue, fontSize: 16),
              ),
              Text(
                StringUtils.capitalize(country2),
                style: TextStyle(color: Colors.red, fontSize: 16),
              )
            ],
          ),
        )
      ],
    ),
  );
}
