import 'package:flutter_todo/domain/entities/task.dart';

class DayList {
  int id;
  String title;
  List<Task> tasks;
  DayList({required this.id, required this.title, List<Task>? tasks})
    : tasks = tasks ?? [];
}
