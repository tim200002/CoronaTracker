import 'package:corona/Assets/helperFunctions.dart';
import 'package:corona/Classes/Results.dart';
import 'package:corona/Widgets/statChart.dart';
import 'package:flutter/cupertino.dart';

abstract class DetailStates {}

//State while Loading Data
class FetchingData extends DetailStates {
  @override
  String toString() => 'Fetching Data from API';
}

//Sate when Data ist Loaded and can be Displayed
class ShowData extends DetailStates {
  //Here the Variables especially the List of Data
  //These are from Type Corona Data
  final List<CoronaData> currentCases;
  final List<CoronaData> deaths;
  final List<CoronaData> recovered;
  final String countryString;

  //also List from Data Type of the Data for the Diagramm;
  List<TimeSeriesCases> currentCasesTimeSeries;
  List<TimeSeriesCases> recoveredCasesTimeSeries;
  List<TimeSeriesCases> deathCasesTimeSeries;

  //Constructor which gets all the Data
  ShowData(
      {@required this.currentCases,
      @required this.deaths,
      @required this.recovered,
      @required this.countryString}) {
    currentCasesTimeSeries = convertResultsToCases(currentCases);
    recoveredCasesTimeSeries = convertResultsToCases(recovered);
    deathCasesTimeSeries = convertResultsToCases(deaths);
  }
}

//When first opened the Screen you are prompet to Enter a County, later evtl. default to a country, better to the Country where Phone is positioned

class InitialData extends DetailStates {}
