import 'package:hive/hive.dart';
part 'todo_item_model.g.dart';

@HiveType(typeId: 0)
class TodoItemModel extends HiveObject {
  @HiveField(1)
  int id;
  @HiveField(2)
  String text;
  @HiveField(3)
  bool value;
  TodoItemModel({required this.id, required this.text, required this.value});
}
