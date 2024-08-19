// bloc_paralysis/bloc.dart
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/paralysis/bloc_paralysis/state.dart';

import 'event.dart';


class ParalysisBloc extends Bloc<ParalysisEvent, ParalysisState> {
  ParalysisBloc() : super(ParalysisState(fields: {})) {
    on<UpdateParalysisField>((event, emit) {
      final updatedFields = Map<String, String>.from(state.fields)
        ..[event.fieldName] = event.fieldValue;
      emit(state.copyWith(fields: updatedFields));
    });

    on<SubmitParalysisForm>((event, emit) {
      _printAllFields(state.fields);
    });
  }

  void _printAllFields(Map<String, String> fields) {
    print("Current form state:");
    String jsonFields = jsonEncode(fields);
    print(jsonFields);
  }
}
