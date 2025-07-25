import 'package:flutter/material.dart';
import 'package:flutter_todo/presentation/widgets/new_todo_modal.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key, required this.title});
  final String title;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Map<String, dynamic>> todosInfo = [];

  bool isTodoCreationModalOpen = false;

  void onChanged(int index, bool? value) {
    setState(() {
      todosInfo[index]["value"] = value;
    });
  }

  List<Widget> getListOfTodos() {
    List<Widget> todos = [];

    for (var i = 0; i < todosInfo.length; i++) {
      todos.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              value: todosInfo[i]["value"],
              onChanged: (bool? newValue) => onChanged(i, newValue),
            ),
            Text(todosInfo[i]["text"], style: TextStyle(color: Colors.white)),
          ],
        ),
      );
    }
    return todos;
  }

  void _toggleTodoOpenModal() {
    setState(() {
      isTodoCreationModalOpen = !isTodoCreationModalOpen;
    });
  }

  void _saveTodo(String text) {
    setState(() {
      todosInfo.add({"id": todosInfo.length + 1, "value": false, "text": text});
    });
    _toggleTodoOpenModal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(widget.title),
        titleTextStyle: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: isTodoCreationModalOpen
            ? NewTodoModal(
                title: "Create todo",
                onSave: (text) => _saveTodo(text),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: getListOfTodos(),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleTodoOpenModal,
        backgroundColor: Colors.white,
        tooltip: 'Create new todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
