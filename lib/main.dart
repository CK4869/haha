import 'package:flutter/material.dart';

String text = '';
void main() {
  text = const String.fromEnvironment('API_KEY', defaultValue: 'Hello World!');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text(text + 'huhu'),
        ),
      ),
    );
  }
}
