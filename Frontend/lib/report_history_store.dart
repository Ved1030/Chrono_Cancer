import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class ReportHistoryStore {
  static List<Map<String, dynamic>> history = [];
  static bool initialized = false;

  static Future<void> init() async {
    if (initialized) return;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? saved = prefs.getString("saved_reports");

    if (saved != null) {
      try {
        history = List<Map<String, dynamic>>.from(jsonDecode(saved));
      } catch (e) {
        history = [];
      }
    }
    initialized = true;
  }

  static Future<void> add(String filename, String aiText, String timestamp) async {
    history.add({
      "file": filename,
      "time": timestamp,
      "analysis": aiText,
    });

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("saved_reports", jsonEncode(history));
  }
}
