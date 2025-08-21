import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

  void selectTodo(int index) {
    setState(() => _selectedDayListIndex = index);
  }

  List<Widget> getDayLists(List<DayList> dayLists) {
    return [
      for (var i = 0; i < dayLists.length; i++)
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
    ];
  }

  void _saveDayList(String text) {
    ref.read(dayListsProvider.notifier).addDayList(text);
  }

  void _saveTask(String title, String dayListId) {
    ref.read(dayListsProvider.notifier).addTask(dayListId, title);
  }

  Widget _buildBodyContent(List<DayList> dayLists) {
    bool isSomeDayListSelected = _selectedDayListIndex != null;

    final selectedDayList = dayLists[_selectedDayListIndex!];

    return isSomeDayListSelected
        ? TasksList(
            taskListId: selectedDayList.id,
            title: selectedDayList.title,
            tasks: selectedDayList.tasks,
          )
        : Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [const SizedBox(height: 20), ...getDayLists(dayLists)],
          );
  }

  @override
  Widget build(BuildContext context) {
    final dayLists = ref.watch(dayListsProvider);

    return Scaffold(
      body: _buildBodyContent(dayLists),
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, 'new-task'),
        backgroundColor: Colors.amber[800],
        child: const Icon(Icons.add),
      ),
    );
  }
}
