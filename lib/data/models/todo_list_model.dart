import 'package:flutter_todo/data/models/todo_item_model.dart';
import 'package:hive/hive.dart';

class TodoListModel extends HiveObject {
  int id;
  String title;
  List<TodoItemModel> items = [];
  TodoListModel({required this.id, required this.title, List<TodoItemModel>? items});
}
