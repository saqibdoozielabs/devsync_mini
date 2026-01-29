import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DevSync Mini',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Day 1: Fundamentals'),
        ),
        body: Center(
          child: Text(
            'Ready to Learn!',
            style: TextStyle(fontSize: 24),
          ),
        ),
      )
    );
  }
}

// export 'apps/day1/app1_hello.dart';