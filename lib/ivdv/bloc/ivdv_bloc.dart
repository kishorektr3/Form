import 'package:flutter_bloc/flutter_bloc.dart';
import 'ivdv_event.dart';
import 'ivdv_state.dart';
import 'dart:convert';

class IvdvBloc
    extends Bloc<IvdvEvent, IvdvState> {
  IvdvBloc() : super(IvdvState(fields: {})) {
    on<UpdateField>((event, emit) {
      final updatedFields = Map<String, String>.from(state.fields)
        ..[event.fieldName] = event.fieldValue;
      emit(state.copyWith(updatedFields: updatedFields));
    });
    on<SubmitForm>((event, emit) {
      _printAllFields(state.fields);
    });
  }
  void _printAllFields(Map<String, String> fields) {
    print("Current form state:");
    String jsonFields = jsonEncode(fields);
    print(jsonFields);
  }
}
