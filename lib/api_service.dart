import 'package:http/http.dart' as http;
import 'dart:convert';

class ApiService {
  static Future<Map<String, dynamic>> sendData(String routesText, String distributionText) async {
    final response = await http.post(
      Uri.parse('http://192.168.1.3:5000/process'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'routes_text': routesText,
        'distribution_text': distributionText,
      }),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Error: ${response.reasonPhrase}');
    }
  }
}
