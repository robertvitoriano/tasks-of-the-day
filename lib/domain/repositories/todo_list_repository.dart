import 'package:flutter_todo/domain/entities/todo_list.dart';

abstract class TodoListRepository {
  TodoList? getTodoList({required String id});

  Future<void> storeTodoList({required String id, required TodoList todoList});
}
