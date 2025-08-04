
import 'package:flutter/material.dart';
import 'package:flutter_todo/presentation/pages/todo_list.dart';
import 'package:flutter_todo/presentation/widgets/new_todo_modal.dart';

/// Model for a single todo item
class TodoItem {
  int id;
  String text;
  bool value;
  TodoItem({required this.id, required this.text, this.value = false});
}

/// Model for a todo list
class TodoListModel {
  int id;
  String title;
  List<TodoItem> items;
  TodoListModel({required this.id, required this.title, List<TodoItem>? items})
      : items = items ?? [];
}

class Home extends StatefulWidget {
  const Home({super.key, required this.title});
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  /// List of todo lists
  final List<TodoListModel> todoLists = [];

  bool isTodoCreationModalOpen = false;
  int? _selectedTodoIndex;
  
  /// Select a todo list by index
  void selectTodo(int index) {
    setState(() => _selectedTodoIndex = index);
  }
   
  /// Returns a list of widgets for each todo list
  List<Widget> getTodoLists() {
    final List<Widget> lists = [];
    for (var i = 0; i < todoLists.length; i++) {
      lists.add(
        GestureDetector(
          onTap: () => setState(() => _selectedTodoIndex = i),
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
  /// Handles checkbox change for todo items
  void onChanged(int index, bool? value) {
    if (_selectedTodoIndex == null) return;
    setState(() {
      todoLists[_selectedTodoIndex!].items[index].value = value ?? false;
    });
  }
  /// Save a new todo list
  void _saveTodoList(String text) {
    setState(() {
      todoLists.add(TodoListModel(id: todoLists.length + 1, title: text));
    });
    _toggleTodoCreationModal();
  }

  /// Save a new todo item to the selected list
  void _saveTodoItem(String text) {
    if (_selectedTodoIndex == null) return;
    setState(() {
      final items = todoLists[_selectedTodoIndex!].items;
      items.add(TodoItem(id: items.length + 1, text: text));
    });
    _toggleTodoCreationModal();
  }
  // Removed unused getSelectedTodoItems method

  /// Toggle the creation modal
  void _toggleTodoCreationModal() {
    setState(() {
      isTodoCreationModalOpen = !isTodoCreationModalOpen;
    });
  }

  // Removed redundant _saveTodo method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: _selectedTodoIndex != null
            ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  setState(() {
                    _selectedTodoIndex = null;
                  });
                },
              )
            : null,
        title: Text(widget.title),
        titleTextStyle: const TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.black,
      body: _selectedTodoIndex == null
          ? Center(
              child: isTodoCreationModalOpen
                  ? CreationModal(
                      title: "Create Todo List",
                      onSave: (String text) => _saveTodoList(text),
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [SizedBox(height: 20), ...getTodoLists()],
                    ),
            )
          : isTodoCreationModalOpen
              ? Center(
                  child: CreationModal(
                    title: "Create Todo Item",
                    onSave: (String text) => _saveTodoItem(text),
                  ),
                )
              : TodoList(
                  title: todoLists[_selectedTodoIndex!].title,
                  todos: todoLists[_selectedTodoIndex!].items,
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleTodoCreationModal,
        backgroundColor: Colors.white,
        tooltip: _selectedTodoIndex == null
            ? 'Create new todo list'
            : 'Create new todo item',
        child: const Icon(Icons.add),
      ),
    );
  }
}
