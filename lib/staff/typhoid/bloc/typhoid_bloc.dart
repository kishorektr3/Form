import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';

import 'typhoid_event.dart';
import 'typhoid_state.dart';

class TyphoidBloc extends Bloc<TyphoidEvent, TyphoidState> {
  TyphoidBloc() : super(TyphoidState(fields: {})) {
    // Handle single field updates
    on<UpdateField>((event, emit) {
      final updatedFields = Map<String, dynamic>.from(state.fields)
        ..[event.fieldName] = event.fieldValue;
      emit(state.copyWith(updatedFields: updatedFields));
    });

    // Handle multiple selection field updates
    on<UpdateMultipleSelectionField>((event, emit) {
      final updatedFields = Map<String, dynamic>.from(state.fields)
        ..[event.fieldName] = event.selectedValues;
      emit(state.copyWith(updatedFields: updatedFields));
    });

    // Handle form submission
    on<SubmitForm>((event, emit) {
      _printAllFields(state.fields);

      // Reset the fields after submission
      emit(state.copyWith(
        updatedFields: {}, // Clear the fields
        submissionStatus: 'Submitted successfully',
      ));
    });
  }

  // Method to print all fields in JSON format
  void _printAllFields(Map<String, dynamic> fields) {
    print("Current form state:");
    String jsonFields = jsonEncode(fields);
    print(jsonFields);
  }
}
