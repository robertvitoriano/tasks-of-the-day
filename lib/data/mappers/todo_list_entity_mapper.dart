import 'package:flutter_todo/data/models/todo_item_model.dart';
import 'package:flutter_todo/data/models/todo_list_model.dart';
import 'package:flutter_todo/domain/entities/todo_item.dart';
import 'package:flutter_todo/domain/entities/todo_list.dart';

extension TodoListEntityMapper on TodoList {
  TodoListModel toModel() {
    return TodoListModel(
      id: id,
      title: title,
      items: items.map((i) => i.toModel()).toList(),
    );
  }
}

extension TodoItemEntityMapper on TodoItem {
  TodoItemModel toModel() {
    return TodoItemModel(id: id, text: text, value: value);
  }
}
