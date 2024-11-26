import 'dart:convert';
import 'package:dma_inc/consts/consts.dart';
import 'package:http/http.dart' as http;

class SignupServices {
  final String baseUrl = 'https://dma-inc.net/wp-json/wc/v3/customers';

  Future<Map<String, dynamic>> createUser(Map<String, dynamic> userData) async {
    const String credentials = '$key:$shhh';
    final String encodedCredentials = base64Encode(utf8.encode(credentials));

    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Basic $encodedCredentials',
      },
      body: jsonEncode(userData),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create user: ${response.body}');
    }
  }
}
