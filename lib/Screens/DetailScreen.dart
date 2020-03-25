import 'package:basic_utils/basic_utils.dart';
import 'package:corona/Assets/Styling.dart';
import 'package:corona/Widgets/statChart.dart';
import 'package:corona/Widgets/statChart.dart';
import 'package:corona/blocs/blocDetailScreen.dart';
import 'package:corona/events/detailEvents.dart';
import 'package:corona/states/detailStates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//!Todo Redesign a bit it isn't necessary to define the text Fields two times

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final BlocDetailScreen blocDetailScreen =
        BlocProvider.of<BlocDetailScreen>(context);
    return BlocBuilder<BlocDetailScreen, DetailStates>(
        builder: (context, state) {
      //When the App is started you are prompted to Enter Some Data
      if (state is InitialData) {
        //! Todo Screen with Adress Bar and nothing more just a Prompt to Enter a Country
        //Controller for Input Field
        final countryController = TextEditingController();
        //Text Input Field for the Country
        final countryField = TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'You need to Input a country';
              }
              return null;
            },
            //If Submitted call API later we need some Validation logic
            onFieldSubmitted: (String str) {
              blocDetailScreen.add(getNewData(searchString: str.toLowerCase()));
            },
            controller: countryController, //Not Sure if Really Needed
            obscureText: false,
            style: TextStyle(color: Colors.grey),
            decoration:
                createNewCountryFieldInputDecoration('Please Enter a Country'));

        return Container(
          padding: const EdgeInsets.all(8),
          child: Column(children: <Widget>[
            //Top Input Bar
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: countryField,
            ),

            Text("Please Enter Some Data"),
          ]),
        );
      } else if (state is FetchingData) {
        // Show a Laoding circle not sure if Adress Bar will stay there, dann muss man Variable übergeben
        return Center(
          child: CircularProgressIndicator(),
        );
      } else if (state is ShowData) {
        //All the Data Laoded show Diagramm etc.

        //Controller for Input Field
        final countryController = TextEditingController(
            text: StringUtils.capitalize(state.countryString));

        //Text Input Field for the Country
        final countryField = TextFormField(
            validator: (value) {
              if (value.isEmpty) {
                return 'You need to Input a country';
              }
              return null;
            },
            //If Submitted call API later we need some Validation logic
            onFieldSubmitted: (String str) {
              blocDetailScreen.add(getNewData(searchString: str.toLowerCase()));
            },
            controller: countryController, //Not Sure if really needed
            obscureText: false,
            style: TextStyle(color: Colors.grey),
            decoration: createNewCountryFieldInputDecoration(
                'Please Insert a Country'));

        return Container(
          padding: const EdgeInsets.all(8),
          // color: Colors.yellow,
          child: Column(
            children: <Widget>[
              //Top Input Bar
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: countryField,
              ),
              //The Box with the most Important Facts
              Expanded(
                flex: 2,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RichText(
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(text: "Date: ", style: boxHeadlineStyle),
                          TextSpan(
                              text: state
                                  .currentCases[state.currentCases.length - 1]
                                  .date
                                  .toString()
                                  .substring(0, 10),
                              style: boxNumberStyle),
                          TextSpan(
                              text: "(Midnight): ", style: boxHeadlineStyle),
                        ]),
                      ),
                      RichText(
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Current Cases: ", style: boxHeadlineStyle),
                          TextSpan(
                              text: state
                                  .currentCases[state.currentCases.length - 1]
                                  .cases
                                  .toString(),
                              style: boxNumberStyle)
                        ]),
                      ),
                      RichText(
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Current Recovered: ",
                              style: boxHeadlineStyle),
                          TextSpan(
                              text: state
                                  .recovered[state.recovered.length - 1].cases
                                  .toString(),
                              style: boxNumberStyle)
                        ]),
                      ),
                      RichText(
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Current Deaths: ",
                              style: boxHeadlineStyle),
                          TextSpan(
                              text: state.deaths[state.deaths.length - 1].cases
                                  .toString(),
                              style: boxNumberStyle)
                        ]),
                      ),
                      RichText(
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Todays Death Rate: ",
                              style: boxHeadlineStyle),
                          TextSpan(
                              text:
                                  (state.deaths[state.deaths.length - 1].cases -
                                          state.deaths[state.deaths.length - 2]
                                              .cases)
                                      .toString(),
                              style: boxNumberStyle),
                          TextSpan(
                              text: " Persons/Day ", style: boxHeadlineStyle),
                        ]),
                      ),
                      RichText(
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                              text: "Todays Infection Rate: ",
                              style: boxHeadlineStyle),
                          TextSpan(
                              text: (state
                                          .currentCases[
                                              state.currentCases.length - 1]
                                          .cases -
                                      state
                                          .currentCases[
                                              state.currentCases.length - 2]
                                          .cases)
                                  .toString(),
                              style: boxNumberStyle),
                          TextSpan(
                              text: " Persons/Day ", style: boxHeadlineStyle),
                        ]),
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 5,
                child: StatChart(
                    currentCases: state.currentCasesTimeSeries,
                    recovered: state.recoveredCasesTimeSeries,
                    deaths: state.deathCasesTimeSeries),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text("Current", style: TextStyle(color: Colors.blue)),
                  Text("Deaths", style: TextStyle(color: Colors.red)),
                  Text(
                    "Recoverd",
                    style: TextStyle(color: Colors.green),
                  )
                ],
              )
            ],
          ),
        );
      }
    });
  }
}

//Text Style Used for the Box:
final TextStyle boxHeadlineStyle = new TextStyle(
    fontSize: 18, fontWeight: FontWeight.normal, color: Colors.black87);
final TextStyle boxNumberStyle = new TextStyle(
    fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87);
