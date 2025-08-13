import 'package:flutter_todo/data/models/task_model.dart';
import 'package:flutter_todo/data/models/day_list_model.dart';
import 'package:flutter_todo/domain/entities/task.dart';
import 'package:flutter_todo/domain/entities/day_list.dart';

extension DayListModelMapper on DayListModel {
  DayList toEntity() {
    return DayList(
      id: id,
      title: title,
      tasks: tasks.map((i) => i.toEntity()).toList(),
    );
  }
}

extension TaskModelMapper on TaskModel {
  Task toEntity() {
    return Task(
      id: id,
      done: done,
      title: title,
      category: category,
      description: description,
      dueTime: dueTime,
      priority: priority,
    );
  }
}
