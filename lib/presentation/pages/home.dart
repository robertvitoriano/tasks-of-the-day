import 'package:flutter/material.dart';
import 'package:flutter_todo/presentation/pages/todo_list.dart';
import 'package:flutter_todo/presentation/widgets/new_todo_modal.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.title});
  final String title;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> todoLists = [];

  bool isTodoCreationModalOpen = false;
  int? _selectedTodoIndex;
  
  void selectTodo(int index){
    setState(()=>
      _selectedTodoIndex = index
    );
  }
   
  List<Widget> getTodoLists() {
    List<Widget> lists = [];

    for (var i = 0; i < todoLists.length; i++) {
      lists.add(
        GestureDetector(
          onTap:()=> _selectedTodoIndex = i ,
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              todoLists[i]["title"],
              style: TextStyle(color: Colors.black),
            ),
          ),
        )),
      );
    }
    return lists;
  }
  void onChanged(int index, bool? value) {
    setState(() {
      todoLists[_selectedTodoIndex!]["items"][index]["value"] = value;
    });
  }
  void _saveTodoList(String text) {
    setState(() {
      todoLists.add({"id": todoLists.length + 1, "title": text, "items": []});
    });
    _toggleTodoCreationModal();
  }

  void _saveTodoItem(String text) {
    if (_selectedTodoIndex == null) return;
    setState(() {
      // Ensure items is initialized
      todoLists[_selectedTodoIndex!]["items"] ??= [];
      todoLists[_selectedTodoIndex!]["items"].add({
        "id": todoLists[_selectedTodoIndex!]["items"].length + 1,
        "value": false,
        "text": text,
      });
    });
    _toggleTodoCreationModal();
  }
  
  
  List<Widget> getSelectedTodoItems(){
    final selectedTodo = todoLists[_selectedTodoIndex!];
    List<Widget> todoItems = [];
    if(_selectedTodoIndex != null){
      for(int i= 0; i < selectedTodo["items"].length; i++){
        todoItems.add(        
          Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Checkbox(
              value: selectedTodo["items"][i]["value"],
              onChanged: (bool? newValue) => onChanged(i, newValue),
            ),
            Text(selectedTodo["items"][i]["text"], style: TextStyle(color: Colors.white)),
          ],
        ));
      }
    }
    
    return todoItems;
  }

  void _toggleTodoCreationModal() {
    setState(() {
      isTodoCreationModalOpen = !isTodoCreationModalOpen;
    });
  }

  void _saveTodo(String text) {
    setState(() {
      todoLists.add({"id": todoLists.length + 1, "title": text, "items": []});
    });
    _toggleTodoCreationModal();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: _selectedTodoIndex != null
            ? IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () {
                  setState(() {
                    _selectedTodoIndex = null;
                  });
                },
              )
            : null,
        title: Text(widget.title),
        titleTextStyle: TextStyle(color: Colors.black),
      ),
      backgroundColor: Colors.black,
      body: _selectedTodoIndex == null
          ? Center(
              child: isTodoCreationModalOpen
                  ? CreationModal(
                      title: "Create Todo List",
                      onSave: (text) => _saveTodoList(text),
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
                    onSave: (text) => _saveTodoItem(text),
                  ),
                )
              : TodoList(
                  title: todoLists[_selectedTodoIndex!]["title"],
                  todos: todoLists[_selectedTodoIndex!]["items"],
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
