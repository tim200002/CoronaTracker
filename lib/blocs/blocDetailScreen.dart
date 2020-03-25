import 'package:corona/Classes/Results.dart';
import 'package:corona/Widgets/statChart.dart';
import 'package:corona/events/detailEvents.dart';
import 'package:corona/states/detailStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocDetailScreen extends Bloc<DetailEvents, DetailStates> {
  @override
  DetailStates get initialState => InitialData();

  @override
  Stream<DetailStates> mapEventToState(DetailEvents event) async* {
    if (event is getNewData) {
      //Show Loading Screen while Loading the Data
      yield FetchingData();

      //The make API Call
      //Later maybe Nicer with Try and Catch for now just Call
      final List<CoronaData> current =
          await fetchAllCoronaData(event.searchString, 'confirmed');
      final List<CoronaData> deaths =
          await fetchAllCoronaData(event.searchString, 'deaths');
      final List<CoronaData> recovered =
          await fetchAllCoronaData(event.searchString, 'recovered');

      yield ShowData(
          currentCases: current,
          deaths: deaths,
          recovered: recovered,
          countryString: event.searchString);
    }
  }
}
