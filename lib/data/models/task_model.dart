import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(1)
  int id;
  @HiveField(2)
  String title;
  @HiveField(3)
  bool done;
  @HiveField(4)
  String description;
  @HiveField(5)
  String priority;
  @HiveField(6)
  String category;
  @HiveField(7)
  DateTime dueTime;
  @HiveField(8)
  int dayListId;

  TaskModel({
    required this.id,
    required this.dayListId,
    required this.title,
    required this.done,
    required this.description,
    required this.priority,
    required this.category,
    required this.dueTime,
  });
}
