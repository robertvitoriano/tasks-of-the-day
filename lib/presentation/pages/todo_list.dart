import 'package:flutter/material.dart';
import 'package:flutter_todo/presentation/pages/home.dart';
import 'package:flutter_todo/presentation/widgets/new_todo_modal.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key, required this.title, required this.todos});
  final String title;
  final List<TodoItemModel> todos;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  bool isTodoCreationModalOpen = false;

  void onChanged(int index, bool value) {
    setState(() {
      widget.todos[index].value = value;
    });
  }

  List<Widget> getListOfTodos() {
    List<Widget> todos = [];
    print(widget.todos);
    for (var i = 0; i < widget.todos.length; i++) {
      todos.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              value: widget.todos[i].value,
              onChanged: (bool? newValue) => onChanged(i, newValue!),
            ),
            Text(widget.todos[i].text, style: TextStyle(color: Colors.white)),
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
        widget.todos.add(TodoItemModel(id:widget.todos.length + 1 , text: text,value: false));
    });
    _toggleTodoOpenModal();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isTodoCreationModalOpen
          ? NewTodoModal(
              title: "Create Todo Item",
              onSave: (text) => _saveTodo(text),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: getListOfTodos(),
            ),
    );
  }
}
  
