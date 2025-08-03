import 'package:flutter/material.dart';
import 'package:flutter_todo/presentation/pages/home.dart';
import 'package:flutter_todo/presentation/pages/todo_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(title: 'Flutter Todo'),
      title: 'Flutter Todo',
      color: Colors.white,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      routes: <String, WidgetBuilder>{
      '/todo-list': (BuildContext context) => const TodoList(title: 'Flutter Todo'),
      }
    );
  }
}



