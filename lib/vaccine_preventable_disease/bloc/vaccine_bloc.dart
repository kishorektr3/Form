import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/vaccine_preventable_disease/bloc/vaccine_event.dart';
import 'package:untitled/vaccine_preventable_disease/bloc/vaccine_state.dart';


class VaccineBloc extends Bloc<VaccineEvent, VaccineState> {  // Updated class name
  VaccineBloc() : super(VaccineState(fields: {})) {
    on<UpdateVaccineField>((event, emit) {
      final updatedFields = Map<String, String>.from(state.fields)
        ..[event.fieldName] = event.fieldValue;
      emit(state.copyWith(fields: updatedFields));
    });

    on<SubmitVaccineForm>((event, emit) {
      _printAllFields(state.fields);
    });
  }

  void _printAllFields(Map<String, String> fields) {
    print("Current form state:");
    String jsonFields = jsonEncode(fields);
    print(jsonFields);
  }
}
