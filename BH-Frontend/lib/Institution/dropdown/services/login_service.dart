import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';

Future<String> getToken() async {
  final url = Uri.parse('http://localhost:6969/api/auth/login?usernameOrEmail=stefyy&password=Pass1234');
  final response = await http.post(url);

  if (response.statusCode == 200) {
    Map<String, dynamic> json = jsonDecode(response.body);
    UserResponse userResponse = UserResponse.fromJson(json);
    return userResponse.token;
  } else {
    throw Exception('Failed to fetch token');
  }
}


