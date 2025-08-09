import 'package:flutter_todo/data/models/todo_list_model.dart';
import 'package:hive/hive.dart';

class TodoListsLocalDatasource {
  final Box<TodoListModel> box;

  TodoListsLocalDatasource(this.box);
  Future<void> saveTodo({
    required String key,
    required TodoListModel todoList,
  }) async {
    await box.put(key, todoList);
  }

  TodoListModel? getTodoList({required String key}) {
    final todoList = box.get(key);

    if (todoList == null) return null;

    return todoList;
  }
}
