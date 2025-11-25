// lib/pages/n8n.dart
import 'package:flutter/material.dart';
import '../services/n8n_service.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  String result = "Press the button to test";

  void testWorkflow() async {
    try {
      final data = await N8NService.runWorkflow(
        bp: 130,     // Valid input now
        sugar: 250,
        heart_rate: 108,
        disease: "Diabetes",
      );

      setState(() {
        result = data.toString();
      });
    } catch (e) {
      setState(() {
        result = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ChronoCancer Workflow Tester"),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: testWorkflow,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple,
              ),
              child: Text("Run ChronoCancer AI Workflow"),
            ),
            SizedBox(height: 20),
            Text(
              result,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
    );
  }
}