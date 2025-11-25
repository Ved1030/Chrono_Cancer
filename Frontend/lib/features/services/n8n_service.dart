// lib/services/n8n_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class N8NService {
  static const String workflowUrl =
      "https://synapstorm.app.n8n.cloud/webhook/chronocancer";

  static Future<Map<String, dynamic>> runWorkflow({
    required int bp,
    required int sugar,
    required int heart_rate,
    required String disease,
  }) async {
    final body = {
      "bp": bp,
      "sugar": sugar,
      "heart_rate": heart_rate,
      "disease": disease,
    };

    final response = await http.post(
      Uri.parse(workflowUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
          "Workflow failed: ${response.statusCode} → ${response.body}");
    }
  }
}