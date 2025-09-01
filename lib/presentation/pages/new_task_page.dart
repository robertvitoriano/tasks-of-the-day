import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/domain/enums/category_enum.dart';
import 'package:flutter_todo/domain/enums/priority_enum.dart';
import 'package:flutter_todo/presentation/widgets/custom_dropdown.dart';
import 'package:flutter_todo/presentation/widgets/priority_item.dart';
import 'package:flutter_todo/presentation/widgets/custom_text_field.dart';
import 'package:flutter_todo/providers/day_lists_provider_provider.dart';
import 'package:go_router/go_router.dart';

class NewTask extends ConsumerStatefulWidget {
  const NewTask({super.key, required this.dayListId, required this.title});

  final String title;
  final String dayListId;

  @override
  ConsumerState<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends ConsumerState<NewTask> {
  final _newTaskDescriptionController = TextEditingController();
  final _newTaskTitleController = TextEditingController();
  DateTime? _dueTime;

  void _saveTask() {
    final description = _newTaskDescriptionController.text.trim();
    final title = _newTaskTitleController.text.trim();

    if (description.isNotEmpty) {
      ref
          .read(dayListsProvider.notifier)
          .addTask(
            dayListId: widget.dayListId,
            description: description,
            category: selectedCategory!,
            title: title,
            priority: selectedPriority!,
            dueTime: _dueTime != null ? _dueTime! : DateTime.now(),
          );
      context.go('/day-list/${widget.dayListId}');
    }
  }

  Future<void> _pickDueTime() async {
    final now = DateTime.now();
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      final dueDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      setState(() {
        _dueTime = dueDateTime;
      });
    }
  }

  String? selectedCategory;
  String? selectedPriority;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/day-list/${widget.dayListId}');
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
                controller: _newTaskTitleController,
                hintText: "Digite o titulo",
                type: CustomTextFieldType.text,
                label: "Task title",
              ),
              CustomTextField(
                controller: _newTaskDescriptionController,
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
                      items: Category.values.map((category) {
                        return DropdownMenuItem<String>(
                          value: category.label,
                          child: Text(category.label),
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
                    selectedValue: selectedPriority,
                    description: 'Please select a priority',
                    labelText: 'Priority',
                    items: PriorityLevel.values.map((priority) {
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
                        selectedPriority = value;
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 20),
              InkWell(
                onTap: _pickDueTime,
                child: InputDecorator(
                  decoration: InputDecoration(
                    labelText: "Due Time",
                    border: OutlineInputBorder(),
                  ),
                  child: Text(
                    _dueTime != null
                        ? "${_dueTime!.hour}:${_dueTime!.minute}"
                        : "Select a time",
                    style: TextStyle(
                      color: _dueTime == null ? Colors.grey : Colors.black,
                    ),
                  ),
                ),
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
