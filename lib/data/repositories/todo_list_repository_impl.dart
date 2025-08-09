import 'package:flutter_todo/data/datasources/todo_lists_local_datasource.dart';
import 'package:flutter_todo/data/mappers/todo_list_entity_mapper.dart';
import 'package:flutter_todo/data/mappers/todo_list_model_mapper.dart';
import 'package:flutter_todo/domain/entities/todo_list.dart';
import 'package:flutter_todo/domain/repositories/todo_list_repository.dart';

class TodoListRepositoryImpl implements TodoListRepository {
  TodoListRepositoryImpl({required this.todoListsLocalDataSource});

  final TodoListsLocalDatasource todoListsLocalDataSource;

  @override
  TodoList? getTodoList({required String id}) {
    final todoListModel = todoListsLocalDataSource.getTodoList(key: id);

    return todoListModel?.toEntity();
  }

  @override
  Future<void> storeTodoList({
    required String id,
    required TodoList todoList,
  }) async {
    await todoListsLocalDataSource.saveTodo(
      key: id,
      todoList: todoList.toModel(),
    );
  }
}
