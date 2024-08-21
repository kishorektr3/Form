import 'package:http/http.dart' as http;
import 'dart:convert';

class RubellaRepository {
  final String apiUrl;

  RubellaRepository({required this.apiUrl});

  Future<void> submitForm(Map<String, dynamic> fields) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(fields),
      );

      if (response.statusCode == 200) {
        print("Form submitted successfully");
      } else {
        print("Failed to submit form: ${response.statusCode}");
      }
    } catch (e) {
      print("Error submitting form: $e");
    }
  }
}
