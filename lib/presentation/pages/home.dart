import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/domain/entities/task.dart';
import 'package:flutter_todo/domain/entities/day_list.dart';
import 'package:flutter_todo/presentation/widgets/tasks_list.dart';
import 'package:flutter_todo/presentation/pages/new_task.dart';
import 'package:flutter_todo/providers/tasks_provider.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomeState();
}

class _HomeState extends ConsumerState<HomePage> {
  int? _selectedDayListIndex;

  bool isTodoCreationModalOpen = false;
  final List<DayList> dayLists = [];
  void selectTodo(int index) {
    setState(() => _selectedDayListIndex = index);
  }

  List<Widget> getDayLists() {
    final List<Widget> lists = [];
    for (var i = 0; i < dayLists.length; i++) {
      lists.add(
        GestureDetector(
          onTap: () => selectTodo(i),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                dayLists[i].title,
                style: const TextStyle(color: Colors.black),
              ),
            ),
          ),
        ),
      );
    }
    return lists;
  }

  void onChanged(int index, bool? done) {
    if (_selectedDayListIndex == null) return;
    setState(() {
      dayLists[_selectedDayListIndex!].tasks[index].done = done ?? false;
    });
  }

  void _saveDayList(String text) {
    setState(() {
      dayLists.add(DayList(id: dayLists.length + 1, title: text));
    });
    _toggleTodoCreationModal();
  }

  void _saveTask(String title, int dayListId) {
    if (_selectedDayListIndex == null) return;
    setState(() {
      final tasks = dayLists[_selectedDayListIndex!].tasks;
      tasks.add(Task(dayListId: dayListId, id: tasks.length + 1, title: title));
    });
    _toggleTodoCreationModal();
  }

  void _toggleTodoCreationModal() {
    setState(() {
      isTodoCreationModalOpen = !isTodoCreationModalOpen;
    });
  }

  Widget _buildBodyContent() {
    bool isSomeDayListSelected = _selectedDayListIndex != null;

    if (!isSomeDayListSelected) {
      return isTodoCreationModalOpen
          ? NewTask(
              title: "Create Todo List",
              onSave: (String text) => _saveDayList(text),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [SizedBox(height: 20), ...getDayLists()],
            );
    }

    return isTodoCreationModalOpen
        ? NewTask(
            title: "Create Item",
            onSave: (String text) => _saveTask(text, _selectedDayListIndex!),
          )
        : TasksList(
            taskListId: _selectedDayListIndex! ,
            title: dayLists[_selectedDayListIndex!].title,
            // tasks: dayLists[_selectedDayListIndex!].tasks,
            tasks: ref.watch(tasksProvider)
          );
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: _buildBodyContent(),
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, 'new-task'),
        backgroundColor: Colors.amber[800],
        child: const Icon(Icons.add),
      ),
    );
  }
}
