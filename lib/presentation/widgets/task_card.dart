import 'package:flutter/material.dart';
import 'package:flutter_todo/domain/entities/todo_item.dart';

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
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
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
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          "New todo created",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                    Row(
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
                        const Text(
                          "Generic",
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
