import 'package:flutter/material.dart';
import 'package:flutter_todo/domain/entities/todo_item.dart';

class Todo {
  final String text;
  final bool value;
  Todo({required this.text, required this.value});
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Checkbox(
          value: todo.value,
          onChanged: (bool? newValue) {
            if (newValue != null) {
              onChanged(index, newValue);
            }
          },
        ),
        Text(todo.text, style: const TextStyle(color: Colors.white)),
      ],
    );
  }
}
