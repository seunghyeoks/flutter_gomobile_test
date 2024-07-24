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
      // 1. asset 파일 읽기
      String content = await rootBundle.loadString('assets/test.txt');
      
      // 2. 임시 파일 생성 및 내용 쓰기
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      File tempFile = File('$tempPath/temp_test.txt');
      await tempFile.writeAsString(content);

      // 3. Go 라이브러리에 임시 파일 경로 전달
      final String result = await platform.invokeMethod('readFileContent', {"filePath": tempFile.path});
      print('File content: $result');

      // 4. 임시 파일 삭제 (선택사항)
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