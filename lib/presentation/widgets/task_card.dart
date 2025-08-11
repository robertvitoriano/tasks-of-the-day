import 'package:flutter/material.dart';
import 'package:flutter_todo/domain/entities/todo_item.dart';

class _TodoHeader extends StatelessWidget {
  const _TodoHeader({required this.todo, required this.index});

  final TodoItem todo;
  final int index;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            todo.text,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Text(
          '7:00',
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
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.grey,
            borderRadius: BorderRadius.circular(8),
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
    required this.index,
  });

  final void Function(int todoIndex, bool newValue) onChanged;
  final TodoItem todo;
  final int index;
  @override
  Widget build(Object context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: todo.value,
          onChanged: (bool? newValue) {
            if (newValue != null) {
              onChanged(index, newValue);
            }
          },
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _TodoHeader(todo: todo, index: index),
              const Text(
                "New todo created",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              _TodoCategory(),
            ],
          ),
        ),
      ],
    );
  }
}

class TodoItemCard extends StatelessWidget {
  const TodoItemCard({
    super.key,
    required this.onChanged,
    required this.todo,
    required this.index,
  });

  final void Function(int todoIndex, bool newValue) onChanged;
  final TodoItem todo;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: _TodoContent(onChanged: onChanged, todo: todo, index: index),
      ),
    );
  }
}
