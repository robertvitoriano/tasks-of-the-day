import 'package:flutter/material.dart';
import 'package:flutter_todo/domain/entities/todo_item.dart';
import 'package:flutter_todo/domain/entities/todo_list.dart';
import 'package:flutter_todo/presentation/widgets/todo_list.dart';
import 'package:flutter_todo/presentation/widgets/new_todo_modal.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final List<TodoList> todoLists = [];
  
  bool isTodoCreationModalOpen = false;
  int? _selectedTodoIndex;

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
      return Center(
        child: isTodoCreationModalOpen
            ? NewTodoModal(
                title: "Create Todo List",
                onSave: (String text) => _saveTodoList(text),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [SizedBox(height: 20), ...getTodoLists()],
              ),
      );
    }
    
    return Center(
      child: isTodoCreationModalOpen
          ? NewTodoModal(
              title: "Create Item",
              onSave: (String text) => _saveTodoItem(text),
            )
          :  TodoItemsList(
              title: todoLists[_selectedTodoIndex!].title,
              todos: todoLists[_selectedTodoIndex!].items,
            ),
    );
  }

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
      body: _buildBodyContent(),
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
