import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/domain/entities/priority.dart';
import 'package:flutter_todo/presentation/widgets/custom_dropdown.dart';
import 'package:flutter_todo/presentation/widgets/priority_item.dart';
import 'package:flutter_todo/presentation/widgets/custom_text_field.dart';
import 'package:flutter_todo/providers/tasks_provider.dart';

class NewTask extends ConsumerStatefulWidget {
  const NewTask({super.key, required this.dayListId, required this.title});

  final String title;
  final String dayListId;

  @override
  ConsumerState<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends ConsumerState<NewTask> {
  final TextEditingController _newTaskController = TextEditingController();

  void _saveTask() {
    final text = _newTaskController.text.trim();
    if (text.isNotEmpty) {
      ref.read(dayListsProvider.notifier).addTask(widget.dayListId, text);
    }
  }

  final List<Priority> priorities = [
    Priority(label: 'Medium Priority', color: Colors.red),
    Priority(label: 'Personal', color: Colors.red),
    Priority(label: 'Shopping', color: Colors.red),
    Priority(label: 'Health', color: Colors.red),
    Priority(label: 'Others', color: Colors.red),
  ];
  final List<String> categories = [
    'Medium Priority',
    'Personal',
    'Shopping',
    'Health',
    'Others',
  ];
  String? selectedCategory;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
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
                maxLines: 5,
              ),

              Row(
                children: [
                  Expanded(
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'Category',
                        border: OutlineInputBorder(),
                      ),
                      value: selectedCategory,
                      items: categories.map((category) {
                        return DropdownMenuItem<String>(
                          value: category,
                          child: Text(category),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedCategory = value;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please select a category';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 80),
                  CustomDropdown(
                    selectedValue: selectedCategory,
                    items: priorities.map((priority) {
                      return DropdownMenuItem<String>(
                        value: priority.label,
                        child: PriorityItem(
                          priority: priority.label,
                          color: priority.color,
                        ),
                      );
                    }).toList(),
                    onSelect: (value) {
                      setState(() {
                        selectedCategory = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              _Buttons(saveTask: () => _saveTask()),
            ],
          ),
        ),
      ),
    );
  }
}

class _Buttons extends StatelessWidget {
  const _Buttons({required this.saveTask});
  final VoidCallback saveTask;
  @override
  Widget build(Object context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextButton(
          onPressed: saveTask,
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
          onPressed: saveTask,
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
