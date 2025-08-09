import 'package:flutter_todo/domain/entities/todo_item_entity.dart';

class TodoListModel {
  int id;
  String title;
  List<TodoItem> items;
  TodoListModel({required this.id, required this.title, List<TodoItem>? items})
    : items = items ?? [];
}
