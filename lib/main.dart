import 'package:flutter/material.dart';
import 'package:vier_gewinnt/presentation/vier_gewinnt_model.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vier Gewinnt',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Vier Gewinnt'),
        ),
        body: VierGewinnt(),
      ),
    );
  }
}
