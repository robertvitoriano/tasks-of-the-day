import 'package:flutter/material.dart';
import 'package:flutter_todo/domain/entities/task.dart';
import 'package:flutter_todo/presentation/widgets/task_card.dart';

class TasksList extends StatefulWidget {
  const TasksList({
    super.key,
    required this.taskListId,
    required this.title,
    required this.tasks,
  });
  final String title;
  final String taskListId;
  final List<Task> tasks;

  @override
  State<TasksList> createState() => _TasksListState();
}

class _TasksListState extends State<TasksList> {
  bool isTodoCreationModalOpen = false;

  List<Widget> getListOftasks() {
    List<Widget> taskCards = [];

    for (var i = 0; i < widget.tasks.length; i++) {
      taskCards.add(
        TaskCard(id: widget.tasks[i].id, taskListId: widget.taskListId),
      );
    }
    return taskCards;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: getListOftasks(),
    );
  }
}
