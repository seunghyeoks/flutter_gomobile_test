import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';


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

  // for Communication with Native
  static const platform = MethodChannel('samplefunc');

  Future<void> _callSum() async {
    try {
      // call a go function through platform.invokeMethod
      final int result = await platform.invokeMethod('sum', {"a": 5, "b": 3});
      print('Sum result: $result');
    } on PlatformException catch (e) {
      print("Failed to call sum: '${e.message}'.");
    }
  }

  Future<void> _callReadFileContent() async {
    try {
      // 1. read file in assets
      String content = await rootBundle.loadString('assets/test.txt');
      
      // 2. copy it to temporary path
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      File tempFile = File('$tempPath/temp_test.txt');
      await tempFile.writeAsString(content);

      // 3. pass the temporary path to Go function
      final String result = await platform.invokeMethod('readFileContent', {"filePath": tempFile.path});
      print('File content: $result');

      // 4. remove temporary file
      await tempFile.delete();
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
              onPressed: _callSum,
              child: const Text('Call Sum'),
            ),
            ElevatedButton(
              onPressed: _callReadFileContent,
              child: const Text('Read File Content'),
            ),
          ],
        ),
      ),
    );
  }
}