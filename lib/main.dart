import 'package:flutter/material.dart';
import 'package:flutter_todo/data/models/todo_item_model.dart';
import 'package:flutter_todo/data/models/todo_list_model.dart';
import 'package:flutter_todo/presentation/pages/layout.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(TodoItemModelAdapter());
  Hive.registerAdapter(TodoListModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tasks of the day',
      color: Colors.white,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
      ),
      home: Layout(title: "Tasks of the day"),
    );
  }
}
