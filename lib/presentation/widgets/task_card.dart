import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/domain/entities/task.dart';
import 'package:flutter_todo/providers/tasks_provider.dart';

class TaskCard extends ConsumerStatefulWidget {
  const TaskCard({super.key, required this.id, required this.taskListId});

  final String id;
  final String taskListId;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TaskCard();
  }
}

class _TaskCard extends ConsumerState<TaskCard> {
  void onChanged(String taskId, bool value) {
    ref.read(dayListsProvider.notifier).toggleTask(widget.taskListId, taskId);
  }

  @override
  Widget build(BuildContext context) {
    final dayLists = ref.watch(dayListsProvider);
    final task = dayLists
        .firstWhere((d) => d.id == widget.taskListId)
        .tasks
        .firstWhere((t) => t.id == widget.id);
        
    return Card(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: _TodoContent(onChanged: onChanged, todo: task, id: widget.id),
      ),
    );
  }
}

class _TodoHeader extends StatelessWidget {
  const _TodoHeader({required this.todo, required this.id});

  final Task todo;
  final String id;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            todo.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          '${todo.dueTime.hour.toString()}:${todo.dueTime.minute.toString()}',
          style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
        ),
      ],
    );
  }
}

class _TodoCategory extends StatelessWidget {
  @override
  Widget build(Object context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: Colors.red,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            "Generic",
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ),
      ],
    );
  }
}

class _TodoContent extends StatelessWidget {
  const _TodoContent({
    required this.onChanged,
    required this.todo,
    required this.id,
  });

  final void Function(String todoId, bool newValue) onChanged;
  final Task todo;
  final String id;
  @override
  Widget build(Object context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: todo.done,
          onChanged: (bool? newValue) {
            if (newValue != null) {
              onChanged(id, newValue);
            }
          },
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TodoHeader(todo: todo, id: id),
              const Text(
                "New todo created",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              SizedBox(height: 10),
              _TodoCategory(),
            ],
          ),
        ),
      ],
    );
  }
}
