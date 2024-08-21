import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/HomePage/bloc_home/state.dart';

import 'event.dart';

class DiseaseBloc extends Bloc<DiseaseEvent, DiseaseState> {
  DiseaseBloc() : super(InitialDiseaseState());

  @override
  Stream<DiseaseState> mapEventToState(DiseaseEvent event) async* {
    if (event is SelectDiseaseEvent) {
      yield DiseaseScreenState(event.diseaseScreenType);
    }
  }
}