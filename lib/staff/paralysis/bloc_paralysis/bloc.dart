// ignore_for_file: prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'event.dart';
import 'state.dart';

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
