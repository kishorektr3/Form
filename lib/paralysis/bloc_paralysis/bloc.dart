import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/paralysis/bloc_paralysis/state.dart';
import 'dart:convert';

import 'event.dart';  // Ensure this file contains definitions for ParalysisEvent, UpdateField, SubmitForm

class ParalysisBloc extends Bloc<ParalysisEvent, ParalysisState> {
  ParalysisBloc() : super(ParalysisState(fields: {})) {
    on<UpdateField>((event, emit) {
      final updatedFields = Map<String, dynamic>.from(state.fields)
        ..[event.fieldName] = event.fieldValue;
      emit(state.copyWith(updatedFields: updatedFields));
    });

    on<SubmitForm>((event, emit) {
      _printAllFields(state.fields);
    });
  }

  void _printAllFields(Map<String, dynamic> fields) {
    print("Current form state:");
    String jsonFields = jsonEncode(fields);
    print(jsonFields);
  }
}
