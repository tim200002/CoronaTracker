import 'package:flutter/material.dart';

class StatScreen extends StatefulWidget {
  @override
  _StatScreenState createState() => _StatScreenState();
}

class _StatScreenState extends State<StatScreen> {
  @override
  Widget build(BuildContext context) {
    final countryController = TextEditingController();
    //Text Input Field for the Country
    final countryField = TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'You need to Input a country';
        }
        return null;
      },
      controller: countryController,
      obscureText: false,
      style: TextStyle(color: Colors.grey),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: "Country",
        hintStyle: TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32.0),
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
    );

    return Container(
        child: Column(
      children: <Widget>[
        countryField,
      ],
    ));
  }
}
