import 'package:hive/hive.dart';
part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(1)
  int id;
  @HiveField(2)
  String text;
  @HiveField(3)
  bool done;
  TaskModel({required this.id, required this.text, required this.done});
}
