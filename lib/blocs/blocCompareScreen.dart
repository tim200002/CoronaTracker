import 'package:corona/Classes/Results.dart';
import 'package:corona/events/compareEvents.dart';
import 'package:corona/events/detailEvents.dart';
import 'package:corona/states/compareStates.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocCompareScreen extends Bloc<CompareEvents, CompareStates> {
  @override
  CompareStates get initialState => InitialData();

  @override
  Stream<CompareStates> mapEventToState(CompareEvents event) async* {
    if (event is NewComparissonEvent) {
      //Show Loading while fetching the Data
      yield FetchingData();

      //Make API Call
      final List<CoronaData> current1 =
          await fetchAllCoronaData(event.countryString1, 'confirmed');
      final List<CoronaData> deaths1 =
          await fetchAllCoronaData(event.countryString1, 'deaths');
      final List<CoronaData> recovered1 =
          await fetchAllCoronaData(event.countryString1, 'recovered');

      final List<CoronaData> current2 =
          await fetchAllCoronaData(event.countryString2, 'confirmed');
      final List<CoronaData> deaths2 =
          await fetchAllCoronaData(event.countryString2, 'deaths');
      final List<CoronaData> recovered2 =
          await fetchAllCoronaData(event.countryString2, 'recovered');
      //Go to new State
      yield ShowData(
          countryString1: event.countryString1,
          countryString2: event.countryString2,
          current1: current1,
          current2: current2,
          deaths1: deaths1,
          deaths2: deaths2,
          recovered1: recovered1,
          recovered2: recovered2);
    }
  }
}
