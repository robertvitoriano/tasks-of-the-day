import 'package:flutter_todo/domain/entities/task.dart';

class DayList {
  final String id;
  final String title;
  final DateTime date;
  final List<Task> tasks;

  DayList({
    required this.id,
    required this.title,
    required this.date, 
    List<Task>? tasks,
  }) : tasks = tasks ?? [];

  DayList copyWith({
    String? id,
    String? title,
    DateTime? date,
    List<Task>? tasks,
  }) {
    return DayList(
      id: id ?? this.id,
      title: title ?? this.title,
      date: date ?? this.date,
      tasks: tasks ?? this.tasks,
    );
  }
}
