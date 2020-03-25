import 'package:flutter/material.dart';

InputDecoration createNewCountryFieldInputDecoration(String hintText) {
  return new InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
    hintText: hintText,
    hintStyle: TextStyle(color: Colors.grey),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.0),
      borderSide: BorderSide(color: Colors.grey),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(32.0),
      borderSide: BorderSide(color: Colors.grey),
    ),
  );
}
