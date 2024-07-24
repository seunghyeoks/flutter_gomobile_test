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
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  static const platform = MethodChannel('samplefunc');  // for Communication with Native
  String _fileContent = 'File content or sum result will be shown here';

  Future<void> _callSum() async {
    try {
      // call a go function through platform.invokeMethod
      final int result = await platform.invokeMethod('sum', {"a": 5, "b": 3});
      debugPrint('Sum result: $result');

      setState(() {
        _fileContent = result.toString();
      });
    } on PlatformException catch (e) {
      debugPrint("Failed to call sum: '${e.message}'.");
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
      debugPrint('File content: $result');

      // 4. remove temporary file
      await tempFile.delete();

      setState(() {
        _fileContent = result;
      });
    } on PlatformException catch (e) {
      debugPrint("Failed to read file content: '${e.message}'.");
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
            Center(
              child: Text(_fileContent)
            ),
          ],
        ),
      ),
    );
  }
}