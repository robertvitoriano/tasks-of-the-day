import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key, required this.title});
  final String title;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  List<Map<String, dynamic>> todosInfo = [
    {
      'id': 1,
      "text": "Aprender gerenciamento básico de estado",
      'value': false,
    },
    {'id': 2, "text": "Renderizar componentes dinamicamente", 'value': false},
  ];

  void _onChanged(bool? value) {}

  List<Widget> getListOfTodos() {
    List<Widget> todos = [];

    for (var i = 0; i < todosInfo.length; i++) {
      todos.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Checkbox(value: todosInfo[i]["value"], onChanged: _onChanged),
            Text(todosInfo[i]["text"], style: TextStyle(color: Colors.white)),
          ],
        ),
      );
    }
    return todos;
  }

  void _openTodoCreationModal() {}

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: getListOfTodos(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _openTodoCreationModal,
        backgroundColor: Colors.white,
        tooltip: 'Create new todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
