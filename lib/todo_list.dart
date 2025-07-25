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
    {
      'id': 3,
      "text": "Entender como passar funções personalizadas por parametro",
      'value': false,
    },
  ];

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
  
  void _saveTodo(){
    setState(() {
      todosInfo.add({
        "id": todosInfo.length + 1,
        "value": false,
        "text":_todoCreationController.text.trim()
      });
    });
    _toggleTodoOpenModal();
  }
  
  final TextEditingController _todoCreationController = TextEditingController();

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
            ? Container(
                width: 300,
                height: 600,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Text(
                      "Criar novo todo",
                      style: TextStyle(fontSize: 36, color: Colors.black),
                    ),
                    TextField(
                      controller: _todoCreationController,
                      decoration: InputDecoration(
                        hintText: "Digite seu novo todo",
                        border: OutlineInputBorder(),
                      ),
                    ),
                    ElevatedButton(onPressed:_saveTodo, child: Text("Salvar")),
                  ],
                ),
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
