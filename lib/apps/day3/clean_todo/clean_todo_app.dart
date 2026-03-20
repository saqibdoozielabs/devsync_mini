import 'package:flutter/material.dart';
import 'presentation/pages/todo_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Q47: Initialize dependency injection
  await di.init();
  
  runApp(const CleanTodoApp());
}

class CleanTodoApp extends StatelessWidget {
  const CleanTodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clean Architecture Todo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const TodoPage(),
    );
  }
}