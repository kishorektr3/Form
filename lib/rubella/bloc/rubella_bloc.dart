import 'package:flutter_bloc/flutter_bloc.dart';

import 'dart:convert';

import 'package:untitled/rubella/bloc/rubella_event.dart';
import 'package:untitled/rubella/bloc/rubella_state.dart';

class RubellaBloc extends Bloc<RubellaEvent, RubellaState> {
  RubellaBloc() : super(RubellaState(fields: {})) {
    on<UpdateField>((event, emit) {
      final updatedFields = Map<String, dynamic>.from(state.fields)
        ..[event.fieldName] = event.fieldValue;

      // Handle conditional fields visibility
      if (event.fieldName == "Similar symptoms in other household contact(s):" &&
          event.fieldValue == "Yes") {
        updatedFields["If yes, No. affected"] = updatedFields["If yes, No. affected"] ?? '';
        updatedFields["Name/s:"] = updatedFields["Name/s:"] ?? '';
      } else if (event.fieldName == "Similar symptoms in other household contact(s):" &&
          event.fieldValue == "No") {
        updatedFields.remove("If yes, No. affected");
        updatedFields.remove("Name/s:");
      }

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
