import 'package:flutter/material.dart';
import 'package:flutter_todo/domain/entities/task.dart';
import 'package:flutter_todo/presentation/pages/new_task.dart';
import 'package:flutter_todo/presentation/widgets/task_card.dart';

class TasksList extends StatefulWidget {
  const TasksList({super.key, required this.taskListId, required this.title, required this.tasks});
  final String title;
  final String taskListId;
  final List<Task> tasks;

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  bool isTodoCreationModalOpen = false;

  void onChanged(int index, bool value) {
    setState(() {
      widget.tasks[index].done = value;
    });
  }

  List<Widget> getListOftasks() {
    List<Widget> tasks = [];

    for (var i = 0; i < widget.tasks.length; i++) {
      tasks.add(
        TaskCard(index: i, onChanged: onChanged, todo: widget.tasks[i]),
      );
    }
    return tasks;
  }

  void _toggleTodoOpenModal() {
    setState(() {
      isTodoCreationModalOpen = !isTodoCreationModalOpen;
    });
  }

  void _saveTodo(String title) {
    setState(() {
      // widget.tasks.add(
      //   Task(id: widget.tasks.length + 1, dayListId: widget.taskListId, title: title, done: false),
      // );
    });
    _toggleTodoOpenModal();
  }

  @override
  Widget build(BuildContext context) {
    return isTodoCreationModalOpen
        ? NewTask(title: "Create Todo Item", onSave: (text) => _saveTodo(text))
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: getListOftasks(),
          );
  }
}
