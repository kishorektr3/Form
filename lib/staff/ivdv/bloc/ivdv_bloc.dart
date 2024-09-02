import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/staff/ivdv/bloc/ivdv_event.dart';
import 'package:untitled/staff/ivdv/bloc/ivdv_state.dart';
import 'dart:convert';

class IvdvBloc extends Bloc<IvdvEvent, IvdvState> {
  IvdvBloc() : super(IvdvState(fields: {})) {
    on<UpdateField>((event, emit) {
      final updatedFields = Map<String, dynamic>.from(state.fields)
        ..[event.fieldName] = event.fieldValue;
      emit(state.copyWith(updatedFields: updatedFields));
    });

    on<SubmitForm>((event, emit) {
      _printAllFields(state.fields);

      // Reset the fields after submission
      emit(state.copyWith(
        updatedFields: {}, // Clear the fields
        submissionStatus:
            'Submitted successfully', // Optionally update submission status
      ));
    });
  }

  void _printAllFields(Map<String, dynamic> fields) {
    print("Current form state:");
    String jsonFields = jsonEncode(fields);
    print(jsonFields);
  }
}
