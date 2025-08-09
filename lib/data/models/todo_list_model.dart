import 'package:flutter_todo/data/models/todo_item_model.dart';
import 'package:hive/hive.dart';
part 'todo_list_model.g.dart';

@HiveType(typeId: 1) 
class TodoListModel extends HiveObject {
  @HiveField(1)
  int id;
  @HiveField(2)
  String title;
  @HiveField(3)
  List<TodoItemModel> items = [];
  
  TodoListModel({
    required this.id,
    required this.title,
    List<TodoItemModel>? items,
  });
}
