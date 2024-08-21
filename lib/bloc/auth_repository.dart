import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRepository {
  final String baseUrl;

  AuthRepository(
      {this.baseUrl = "https://6672ce236ca902ae11b1e111.mockapi.io/form_user"});

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {"Content-Type": "application/json"},
      body: json.encode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      // Handle successful login response, e.g., store tokens
    } else {
      throw Exception('Failed to login');
    }
  }

// Add other methods as needed (e.g., logout, register)
}
