import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/staff/ivdv/bloc/ivdv_state.dart';
import 'dart:convert';
import 'package:untitled/staff/ivdv/bloc/ivdv_event.dart';


class IvdvBloc extends Bloc<IvdvEvent, IvdvState> {
  IvdvBloc() : super(IvdvState(fields: {})) {
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
