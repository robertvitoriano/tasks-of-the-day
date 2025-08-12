import 'package:flutter/material.dart';
import 'package:flutter_todo/domain/entities/todo_item.dart';
import 'package:flutter_todo/domain/entities/todo_list.dart';
import 'package:flutter_todo/presentation/widgets/todo_list.dart';
import 'package:flutter_todo/presentation/widgets/new_todo_modal.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int? _selectedTodoIndex;

  bool isTodoCreationModalOpen = false;
  final List<TodoList> todoLists = [];
  void selectTodo(int index) {
    setState(() => _selectedTodoIndex = index);
  }

  List<Widget> getTodoLists() {
    final List<Widget> lists = [];
    for (var i = 0; i < todoLists.length; i++) {
      lists.add(
        GestureDetector(
          onTap: () => selectTodo(i),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                todoLists[i].title,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      );
    }
    return lists;
  }

  void onChanged(int index, bool? value) {
    if (_selectedTodoIndex == null) return;
    setState(() {
      todoLists[_selectedTodoIndex!].items[index].value = value ?? false;
    });
  }

  void _saveTodoList(String text) {
    setState(() {
      todoLists.add(TodoList(id: todoLists.length + 1, title: text));
    });
    _toggleTodoCreationModal();
  }

  void _saveTodoItem(String text) {
    if (_selectedTodoIndex == null) return;
    setState(() {
      final items = todoLists[_selectedTodoIndex!].items;
      items.add(TodoItem(id: items.length + 1, text: text));
    });
    _toggleTodoCreationModal();
  }

  void _toggleTodoCreationModal() {
    setState(() {
      isTodoCreationModalOpen = !isTodoCreationModalOpen;
    });
  }

  Widget _buildBodyContent() {
    bool isSomeTodoListSelected = _selectedTodoIndex != null;

    if (!isSomeTodoListSelected) {
      return isTodoCreationModalOpen
          ? NewTodoModal(
              title: "Create Todo List",
              onSave: (String text) => _saveTodoList(text),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [SizedBox(height: 20), ...getTodoLists()],
            );
    }

    return isTodoCreationModalOpen
        ? NewTodoModal(
            title: "Create Item",
            onSave: (String text) => _saveTodoItem(text),
          )
        : TodoItemsList(
            title: todoLists[_selectedTodoIndex!].title,
            todos: todoLists[_selectedTodoIndex!].items,
          );
  }

  @override
  Widget build(BuildContext context) {
    bool isSomeTodoListSelected = _selectedTodoIndex != null;
    return Scaffold(
      body: _buildBodyContent(),
      appBar: AppBar(
        title: Text(
          isSomeTodoListSelected
              ? todoLists[_selectedTodoIndex!].title
              : widget.title,
        ),
        leading: isSomeTodoListSelected
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() => _selectedTodoIndex = null);
                },
              )
            : null,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleTodoCreationModal,
        backgroundColor: Colors.amber[800],
        child: const Icon(Icons.add),
      ),
    );
  }
}
