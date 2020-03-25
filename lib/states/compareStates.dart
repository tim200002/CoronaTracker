import 'package:corona/Assets/helperFunctions.dart';
import 'package:corona/Classes/Results.dart';
import 'package:corona/Widgets/statChart.dart';
import 'package:flutter/cupertino.dart';

abstract class CompareStates {}

//State while Loading Data
class FetchingData extends CompareStates {}

//State when Data is Loaded and can be Displayed
class ShowData extends CompareStates {
  //Country Strings
  final String countryString1;
  final String countryString2;

  //Data for the Diagramm
  List<TimeSeriesCases> currentCasesTimeSeries1;
  List<TimeSeriesCases> recoveredCasesTimeSeries1;
  List<TimeSeriesCases> deathCasesTimeSeries1;

  List<TimeSeriesCases> currentCasesTimeSeries2;
  List<TimeSeriesCases> recoveredCasesTimeSeries2;
  List<TimeSeriesCases> deathCasesTimeSeries2;

  ShowData(
      {@required this.countryString1,
      @required this.countryString2,
      List<CoronaData> current1,
      List<CoronaData> deaths1,
      List<CoronaData> recovered1,
      List<CoronaData> current2,
      List<CoronaData> deaths2,
      List<CoronaData> recovered2}) {
    currentCasesTimeSeries1 = convertResultsToCases(current1);
    recoveredCasesTimeSeries1 = convertResultsToCases(recovered1);
    deathCasesTimeSeries1 = convertResultsToCases(deaths1);

    currentCasesTimeSeries2 = convertResultsToCases(current2);
    recoveredCasesTimeSeries2 = convertResultsToCases(recovered2);
    deathCasesTimeSeries2 = convertResultsToCases(deaths2);
  }
}

//When first opened the Screen you are prompet to Enter a County, later evtl. default to a country, better to the Country where Phone is positioned

class InitialData extends CompareStates {}
