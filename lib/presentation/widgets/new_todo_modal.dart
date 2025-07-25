import 'package:flutter/material.dart';

class NewTodoModal extends StatefulWidget {
  const NewTodoModal({super.key, required this.title, required this.onSave});

  final String title;
  final void Function(String text) onSave;

  @override
  State<NewTodoModal> createState() => _NewTodoModalState();
}

class _NewTodoModalState extends State<NewTodoModal> {
  final TextEditingController _newTodoModalController = TextEditingController();

  void _saveTodo() {
    final text = _newTodoModalController.text.trim();
    if (text.isNotEmpty) {
      widget.onSave(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
            controller: _newTodoModalController,
            decoration: InputDecoration(
              hintText: "Digite seu novo todo",
              border: OutlineInputBorder(),
            ),
          ),
          ElevatedButton(onPressed: _saveTodo, child: Text("Salvar")),
        ],
      ),
    );
  }
}
