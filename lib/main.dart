import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platform = MethodChannel('samplefunc');

  Future<void> _callSum() async {
    try {
      final int result = await platform.invokeMethod('sum', {"a": 5, "b": 3});
      print('Sum result: $result');
    } on PlatformException catch (e) {
      print("Failed to call sum: '${e.message}'.");
    }
  }

  Future<void> _callReadFileContent() async {
    try {
      final String result = await platform.invokeMethod('readFileContent', {"filePath": "test.txt"});
      print('File content: $result');
    } on PlatformException catch (e) {
      print("Failed to read file content: '${e.message}'.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Samplefunc Demo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text('Call Sum'),
              onPressed: _callSum,
            ),
            ElevatedButton(
              child: const Text('Read File Content'),
              onPressed: _callReadFileContent,
            ),
          ],
        ),
      ),
    );
  }
}