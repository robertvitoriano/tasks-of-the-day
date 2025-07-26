import 'package:flutter/material.dart';
import 'package:flutter_todo/presentation/widgets/new_todo_modal.dart';

class TodoList extends StatefulWidget {
  const TodoList({super.key, required this.title});
  final String title;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  
  List<Map<String, dynamic>> todoLists = [];

  bool isTodoCreationModalOpen = false;

  void onChanged(int index, bool? value) {
    setState(() {
      todoLists[index]["title"] = value;
    });
  }

  List<Widget> getTodoLists() {
    List<Widget> lists = [];

    for (var i = 0; i < todoLists.length; i++) {
      lists.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(todoLists[i]["title"], style: TextStyle(color: Colors.white)),
          ],
        ),
      );
    }
    return lists;
  }

  void _toggleTodoCreationModal() {
    setState(() {
      isTodoCreationModalOpen = !isTodoCreationModalOpen;
    });
  }

  void _saveTodoList(String text) {
    setState(() {
      todoLists.add({"id": todoLists.length + 1,  "title": text});
    });
    _toggleTodoCreationModal();
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
            ? CreationModal(
                title: "Create Todo List",
                onSave: (text) => _saveTodoList(text),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: getTodoLists(),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleTodoCreationModal,
        backgroundColor: Colors.white,
        tooltip: 'Create new todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
