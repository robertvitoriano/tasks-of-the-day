import 'package:flutter/material.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key, required this.title});
  final String title;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  bool checkboxValue = false;

  void _onChanged(bool? value) {
    setState(() {
      checkboxValue = !checkboxValue;
    });
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
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Checkbox(value: checkboxValue, onChanged: _onChanged),
                Text(
                  "Aprender gerenciamento básico de estado",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Checkbox(value: checkboxValue, onChanged: _onChanged),
                Text(
                  "Renderizar componentes dinamicamente",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ],
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
