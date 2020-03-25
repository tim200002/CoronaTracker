import 'package:flutter/material.dart';

abstract class CompareEvents {}

class NewComparissonEvent extends CompareEvents {
  final String countryString1;
  final String countryString2; //Country String
  NewComparissonEvent(
      {@required this.countryString1, @required this.countryString2});
}
