import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/vaccine_preventable_disease/bloc/vaccine_event.dart';
import 'package:untitled/vaccine_preventable_disease/bloc/vaccine_state.dart';
import 'dart:convert';

class VaccineBloc extends Bloc<VaccineEvent, VaccineState> {
  VaccineBloc() : super(VaccineState(fields: {})) {
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
