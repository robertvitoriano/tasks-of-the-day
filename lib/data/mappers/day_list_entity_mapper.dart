import 'package:flutter_todo/data/models/task_model.dart';
import 'package:flutter_todo/data/models/day_list_model.dart';
import 'package:flutter_todo/domain/entities/task.dart';
import 'package:flutter_todo/domain/entities/day_list.dart';

extension DayListEntityMapper on DayList {
  DayListModel toModel() {
    return DayListModel(
      id: id,
      title: title,
      tasks: tasks.map((i) => i.toModel()).toList(),
    );
  }
}

extension TaskEntityMapper on Task {
  TaskModel toModel() {
    return TaskModel(
      id: id,
      title: title,
      done: done,
      category: category,
      description: description,
      dueTime: dueTime,
      priority: priority,
    );
  }
}
