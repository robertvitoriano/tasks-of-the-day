import 'package:flutter/material.dart';
import 'package:flutter_todo/domain/entities/task.dart';
import 'package:flutter_todo/domain/entities/day_list.dart';
import 'package:flutter_todo/presentation/widgets/tasks_list.dart';
import 'package:flutter_todo/presentation/pages/new_task.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomeState();
}

class _HomeState extends State<HomePage> {
  int? _selectedTodoIndex;

  bool isTodoCreationModalOpen = false;
  final List<DayList> dayLists = [];
  void selectTodo(int index) {
    setState(() => _selectedTodoIndex = index);
  }

  List<Widget> getDayLists() {
    final List<Widget> lists = [];
    for (var i = 0; i < dayLists.length; i++) {
      lists.add(
        GestureDetector(
          onTap: () => selectTodo(i),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                dayLists[i].title,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      );
    }
    return lists;
  }

  void onChanged(int index, bool? done) {
    if (_selectedTodoIndex == null) return;
    setState(() {
      dayLists[_selectedTodoIndex!].tasks[index].done = done ?? false;
    });
  }

  void _saveDayList(String text) {
    setState(() {
      dayLists.add(DayList(id: dayLists.length + 1, title: text));
    });
    _toggleTodoCreationModal();
  }

  void _saveTask(String title) {
    if (_selectedTodoIndex == null) return;
    setState(() {
      final tasks = dayLists[_selectedTodoIndex!].tasks;
      tasks.add(Task(id: tasks.length + 1, title: title));
    });
    _toggleTodoCreationModal();
  }

  void _toggleTodoCreationModal() {
    setState(() {
      isTodoCreationModalOpen = !isTodoCreationModalOpen;
    });
  }

  Widget _buildBodyContent() {
    bool isSomeDayListSelected = _selectedTodoIndex != null;

    if (!isSomeDayListSelected) {
      return isTodoCreationModalOpen
          ? NewTask(
              title: "Create Todo List",
              onSave: (String text) => _saveDayList(text),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [SizedBox(height: 20), ...getDayLists()],
            );
    }

    return isTodoCreationModalOpen
        ? NewTask(
            title: "Create Item",
            onSave: (String text) => _saveTask(text),
          )
        : TasksList(
            title: dayLists[_selectedTodoIndex!].title,
            tasks: dayLists[_selectedTodoIndex!].tasks,
          );
  }

  @override
  Widget build(BuildContext context) {
    bool isSomeDayListSelected = _selectedTodoIndex != null;
    return Scaffold(
      body: _buildBodyContent(),
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          isSomeDayListSelected
              ? dayLists[_selectedTodoIndex!].title
              : widget.title,
        ),
        leading: isSomeDayListSelected
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  setState(() => _selectedTodoIndex = null);
                },
              )
            : null,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, 'new-task'),
        backgroundColor: Colors.amber[800],
        child: const Icon(Icons.add),
      ),
    );
  }
}
