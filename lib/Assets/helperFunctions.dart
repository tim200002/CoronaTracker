//Funciton to Convert all the CoronaData to Data Type for the Diagramm
import 'dart:developer';

import 'package:corona/Classes/Results.dart';
import 'package:corona/Widgets/statChart.dart';

List<TimeSeriesCases> convertResultsToCases(List<CoronaData> cases) {
  List<TimeSeriesCases> caseList = new List<TimeSeriesCases>();
  for (int i = 0; i < cases.length; ++i) {
    caseList.add(new TimeSeriesCases(cases[i].date, cases[i].cases));
  }
  log("Case List length: " + caseList.length.toString());
  return caseList;
}
