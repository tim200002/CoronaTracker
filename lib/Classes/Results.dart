import 'dart:collection';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CoronaData {
  final String country;
  final DateTime date;
  final String status; //either current, deaths or recovered
  final int cases;

  //Construcotr
  CoronaData(
      {@required this.country,
      @required this.date,
      @required this.status,
      @required this.cases});

  //Convert API Json to Object
  factory CoronaData.fromJson(Map<String, dynamic> json) {
    var coronaData = CoronaData(
        country: json['Country'],
        date: DateTime.parse(json['Date']),
        status: json['Status'],
        cases: json['Cases']);
    return coronaData;
  }
}

//Function to Fetch all Corona Data by making an API Call
Future<List<CoronaData>> fetchAllCoronaData(
    String country, String status) async {
  log("Fetching Data from API");
  var response = await http
      .get('https://api.covid19api.com/dayone/country/$country/status/$status');
  List<dynamic> list = json.decode(response.body);
  List<CoronaData> datas = new List();
  //If API Calls goes well
  if (response.statusCode == 200) {
    //Convert Json to Objects by Iterating over each element
    for (int i = 0; i < list.length; ++i) {
      datas.add(CoronaData.fromJson(list[i]));
    }
    //log(datas.length.toString());
    //Sum Up all with Same Date by using hashmap
    HashMap<DateTime, int> dataHash = new HashMap();
    for (int i = 0; i < datas.length; ++i) {
      //log("hash 1 i:" + i.toString());
      if (dataHash.containsKey(datas[i].date)) {
        //log("already key");
        dataHash.update(datas[i].date, (dynamic e) => e + datas[i].cases);
      } else {
        // log("new key");
        dataHash[datas[i].date] = datas[i].cases;
      }
    }
    List<CoronaData> finaldatas = new List();
    dataHash.forEach((key, value) {
      finaldatas.add(new CoronaData(
          country: datas[0].country,
          cases: value,
          date: key,
          status: datas[0].status));
    });

    //Sort List by Date (aufsteigend)

    finaldatas.sort((a, b) {
      if (a.date.isBefore(b.date))
        return -1;
      else
        return 1;
    });
    for (int i = 0; i < finaldatas.length; ++i) {
      log("Finaldata: i:$i:  Date ${finaldatas[i].date}  Cases ${finaldatas[i].cases}");
    }

    return finaldatas;
  }
  //Bad Api Call
  else {
    log("Exception Failed API Call");
    throw Exception('Failed API Call');
  }
}
