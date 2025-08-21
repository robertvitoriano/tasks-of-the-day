import 'package:flutter_todo/domain/entities/task.dart';

class DayList {
  String id;
  String title;
  List<Task> tasks;
  DayList({required this.id, required this.title, List<Task>? tasks})
    : tasks = tasks ?? [];
  DayList copyWith({String? id, String? title, List<Task>? tasks}) {
    return DayList(
      id: id ?? this.id,
      title: title ?? this.title,
      tasks: tasks ?? this.tasks,
    );
  }
}
