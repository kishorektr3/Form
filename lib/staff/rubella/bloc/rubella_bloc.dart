import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:untitled/staff/rubella/bloc/rubella_event.dart';
import 'package:untitled/staff/rubella/bloc/rubella_state.dart';

class RubellaBloc extends Bloc<RubellaEvent, RubellaState> {
  RubellaBloc() : super(RubellaState(fields: {})) {
    on<UpdateField>((event, emit) {
      final updatedFields = Map<String, dynamic>.from(state.fields)
        ..[event.fieldName] = event.fieldValue;

      emit(state.copyWith(updatedFields: updatedFields));
    });

    on<SubmitForm>((event, emit) async {
      final success = await _submitForm(state.fields);

      if (success) {
        emit(state.copyWith(updatedFields: {})); // Reset form fields
      }
    });
  }

  Future<bool> _submitForm(Map<String, dynamic> fields) async {
    final String jsonFields = jsonEncode(fields);
    final String url = 'http://127.0.0.1:8000'; // Update as needed

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonFields,
      );

      if (response.statusCode == 200) {
        print('Form submitted successfully');
        return true;
      } else {
        print('Failed to submit form: ${response.reasonPhrase}');
        return false;
      }
    } on http.ClientException catch (e) {
      print('ClientException: ${e.message}');
      return false;
    } on FormatException catch (e) {
      print('FormatException: ${e.message}');
      return false;
    } catch (e) {
      print('Unexpected error: $e');
      return false;
    }
  }
}
