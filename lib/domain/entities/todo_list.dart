import 'package:flutter_todo/domain/entities/todo_item.dart';

class TodoList {
  int id;
  String title;
  List<TodoItem> items;
  TodoList({required this.id, required this.title, List<TodoItem>? items})
    : items = items ?? [];
}
