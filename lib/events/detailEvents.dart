import 'package:flutter/material.dart';

abstract class DetailEvents {}

class getNewData extends DetailEvents {
  final String searchString; //Country String
  getNewData({@required this.searchString});
}
