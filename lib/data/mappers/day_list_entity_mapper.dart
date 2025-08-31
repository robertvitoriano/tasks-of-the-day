import 'package:flutter_todo/data/models/task_model.dart';
import 'package:flutter_todo/data/models/day_list_model.dart';
import 'package:flutter_todo/domain/entities/task.dart';
import 'package:flutter_todo/domain/entities/day_list.dart';
import 'package:hive/hive.dart';

extension DayListEntityMapper on DayList {
  DayListModel toModel() {
    final taskBox = Hive.box<TaskModel>('tasks');

    final taskModels = tasks.map((i) {
      final model = i.toModel();
      taskBox.put(model.id, model);
      return model;
    }).toList();

    return DayListModel(
      id: id,
      title: title,
      tasks: HiveList(taskBox, objects: taskModels),
      date: date,
    );
  }
}

extension TaskEntityMapper on Task {
  TaskModel toModel() {
    return TaskModel(
      id: id,
      dayListId: dayListId,
      title: title,
      done: done,
      category: category,
      description: description,
      dueTime: dueTime,
      priority: priority,
    );
  }
}
