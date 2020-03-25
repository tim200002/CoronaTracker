import 'package:corona/Assets/Styling.dart';
import 'package:corona/Widgets/compareScreenCard.dart';
import 'package:corona/Widgets/doubleChart.dart';
import 'package:corona/Widgets/statChart.dart';
import 'package:corona/blocs/blocCompareScreen.dart';
import 'package:corona/events/compareEvents.dart';
import 'package:corona/states/compareStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CompareScreen extends StatelessWidget {
  /*
  //Hard Coded Data for Styling purposes
  final List<TimeSeriesCases> testData1 = [
    new TimeSeriesCases(new DateTime(2017, 9, 19), 5),
    new TimeSeriesCases(new DateTime(2017, 9, 26), 25),
    new TimeSeriesCases(new DateTime(2017, 10, 3), 100),
    new TimeSeriesCases(new DateTime(2017, 10, 10), 500),
  ];
  final List<TimeSeriesCases> testData2 = [
    new TimeSeriesCases(new DateTime(2017, 9, 19), 30),
    new TimeSeriesCases(new DateTime(2017, 9, 26), 10),
    new TimeSeriesCases(new DateTime(2017, 10, 3), 70),
    new TimeSeriesCases(new DateTime(2017, 10, 10), 800),
  ];
  */

  @override
  Widget build(BuildContext context) {
    //Instance of the Bloc
    final BlocCompareScreen blocCompareScreen =
        BlocProvider.of<BlocCompareScreen>(context);
    //First Input Field with Controller
    final countryController1 = TextEditingController();

    final countryField1 = TextFormField(
        validator: (value) {
          if (value.isEmpty) {
            return 'You need to Input a country';
          }
          return null;
        },
        controller: countryController1,
        obscureText: false,
        style: TextStyle(color: Colors.grey),
        decoration: createNewCountryFieldInputDecoration('Country 1'));

    //Second Input with Controller:
    final countryController2 = TextEditingController();

    final countryField2 = TextFormField(
      validator: (value) {
        if (value.isEmpty) {
          return 'You need to Input a country';
        }
        return null;
      },
      controller: countryController2,
      obscureText: false,
      style: TextStyle(color: Colors.grey),
      decoration: createNewCountryFieldInputDecoration('Country 2'),
    );

    //Button to Start comparisson
    final compareButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.grey,
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        onPressed: () {
          blocCompareScreen.add(NewComparissonEvent(
              countryString1: countryController1.text.toLowerCase(),
              countryString2: countryController2.text.toLowerCase()));
        },
        child: Text(
          "Compare",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),
        ),
      ),
    );

    return BlocBuilder<BlocCompareScreen, CompareStates>(
      builder: (context, state) {
        if (state is InitialData) {
          return Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                //Fist Input Field
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: countryField1,
                ),

                //Second Input Field
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: countryField2,
                ),
                //Compare Button
                compareButton,
                Text("You need to Enter 2 countries to compare")
              ],
            ),
          );
        } else if (state is FetchingData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ShowData) {
          return Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: <Widget>[
                //Fist Input Field
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: countryField1,
                ),

                //Second Input Field
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: countryField2,
                ),
                //Compare Button
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: compareButton,
                ),
                //Slider with 3 Graphs
                Expanded(
                  child: Swiper(
                    pagination: new SwiperPagination(),
                    itemCount: 3,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return makeCompareScreenCard(
                            "Cases",
                            state.currentCasesTimeSeries1,
                            state.currentCasesTimeSeries2,
                            state.countryString1,
                            state.countryString2);
                      } else if (index == 1) {
                        return makeCompareScreenCard(
                            "Deaths",
                            state.deathCasesTimeSeries1,
                            state.deathCasesTimeSeries2,
                            state.countryString1,
                            state.countryString2);
                      } else if (index == 2) {
                        return makeCompareScreenCard(
                            "Recovered",
                            state.recoveredCasesTimeSeries1,
                            state.recoveredCasesTimeSeries2,
                            state.countryString1,
                            state.countryString2);
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

 
}
