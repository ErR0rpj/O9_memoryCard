import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:o9_memorycard/download_page.dart';
import 'package:o9_memorycard/upload_page.dart';

//TODO: Insert validator.

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('O9 Memory Card'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.upload_rounded),
            label: 'Upload',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download_rounded),
            label: 'Download',
          ),
        ],
        currentIndex: _currentIndex,
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: <Widget>[
          UploadPage(),
          DownloadPage(),
        ],
      ),
    );
  }
}
