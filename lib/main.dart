import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

String apiKey = '';
void main() {
  apiKey =
      const String.fromEnvironment('API_KEY', defaultValue: 'Hello World!');
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String? img;

  Future<void> createImage({
    String textDescription = 'cat',
    int quantity = 1,
    String size = '256x256',
  }) async {
    final response = await http.Client().post(
      Uri.parse('https://api.openai.com/v1/images/generations'),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'prompt': textDescription,
        'n': quantity,
        'size': size,
      }),
    );

    if (response.statusCode == 200) {
      final imageUrl = jsonDecode(response.body)['data'][0]['b64_json'];
      setState(() {
        img = imageUrl;
      });
    } else {
      img = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            const Text('haha'),
            FilledButton(
              onPressed: () async {
                createImage();
              },
              child: const Text('button'),
            ),
            img != null
                ? SizedBox(
                    width: 300,
                    height: 300,
                    child: Image.network(img!),
                  )
                : const Text('NULL'),
          ],
        ),
      ),
    );
  }
}
