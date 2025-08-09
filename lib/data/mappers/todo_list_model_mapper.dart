import 'package:flutter_todo/data/models/todo_item_model.dart';
import 'package:flutter_todo/data/models/todo_list_model.dart';
import 'package:flutter_todo/domain/entities/todo_item.dart';
import 'package:flutter_todo/domain/entities/todo_list.dart';

extension TodoListModelMapper on TodoListModel {
  TodoList toEntity() {
    return TodoList(
      id: id,
      title: title,
      items: items.map((i) => i.toEntity()).toList(),
    );
  }
}

extension TodoItemModelMapper on TodoItemModel {
  TodoItem toEntity() {
    return TodoItem(id: id, value: value, text: text);
  }
}
