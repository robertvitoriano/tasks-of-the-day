import 'package:flutter/material.dart';
import 'package:flutter_todo/data/models/task_model.dart';
import 'package:flutter_todo/data/models/day_list_model.dart';
import 'package:flutter_todo/presentation/pages/layout.dart';
import 'package:flutter_todo/presentation/pages/new_task.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_todo/extensions/colors.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dir = await getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  Hive.registerAdapter(TaskModelAdapter());
  Hive.registerAdapter(DayListModelAdapter());
  runApp(const MyApp());
}

void _save(String text) {}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      color: "#E5FCEF".toColor(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: "#E5FCEF".toColor()),
      ),
      home: Layout(),
      routes: {"new-task": (context) => NewTask(onSave: _save, title: "Add New Task")},
    );
  }
}
