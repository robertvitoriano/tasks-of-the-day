import 'package:flutter/material.dart';
import 'package:flutter_todo/presentation/widgets/custom_text_field.dart';

class NewTask extends StatefulWidget {
  const NewTask({super.key, required this.title, required this.onSave});

  final String title;
  final void Function(String text) onSave;

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  final TextEditingController _newTaskController = TextEditingController();

  void _saveTodo() {
    final text = _newTaskController.text.trim();
    if (text.isNotEmpty) {
      widget.onSave(text);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Task details",
              style: TextStyle(fontSize: 36, color: Colors.black),
            ),
            CustomTextField(
              controller: _newTaskController,
              hintText: "Digite seu novo todo",
              type: CustomTextFieldType.text,
              label: "Task title",
            ),
            CustomTextField(
              controller: _newTaskController,
              hintText: "Digite seu novo todo",
              type: CustomTextFieldType.text,
              label: "Description",
            ),
            _Buttons(saveTodo: _saveTodo),
          ],
        ),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({required this.saveTodo});
  final VoidCallback saveTodo;
  @override
  Widget build(Object context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: saveTodo,
          style: TextButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
              side: BorderSide(color: Colors.grey, width: 1),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Text(
              "Cancel",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(width: 20),
        TextButton(
          onPressed: saveTodo,
          style: TextButton.styleFrom(
            backgroundColor: Colors.amber[800],
            foregroundColor: Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: Row(
              children: [
                Text("+", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(width: 10),
                Text("Add Task", style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
