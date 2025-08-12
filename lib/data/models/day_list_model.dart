import 'package:flutter_todo/data/models/task_model.dart';
import 'package:hive/hive.dart';
part 'day_list_model.g.dart';

@HiveType(typeId: 1) 
class DayListModel extends HiveObject {
  @HiveField(1)
  int id;
  @HiveField(2)
  String title;
  @HiveField(3)
  List<TaskModel> tasks = [];
  
  DayListModel({
    required this.id,
    required this.title,
    List<TaskModel>? tasks,
  });
}
