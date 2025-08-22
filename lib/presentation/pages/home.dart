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

  @override
  void initState() {
    super.initState();
  }

  void selectDayList(int index) {
    setState(() => _selectedDayListIndex = index);
  }

  bool _hasDayListForToday(List<DayList> dayLists) {
    final today = DateTime.now();
    return dayLists.any((list) {
      final listDate = DateTime.parse(list.title);
      return listDate.year == today.year &&
          listDate.month == today.month &&
          listDate.day == today.day;
    });
  }
  
  List<Widget> getDayLists(List<DayList> dayLists) {
    return [
      for (var i = 0; i < dayLists.length; i++)
        GestureDetector(
          onTap: () => selectDayList(i),
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

  void addTodayDayList() {
    ref.read(dayListsProvider.notifier).addTodayDayList();
  }

  void _navigateToNewTaskPage() {
    if (_selectedDayListIndex != null) {
      final dayLists = ref.watch(dayListsProvider);
      final selectedDayList = dayLists[_selectedDayListIndex!];
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => NewTask(
            dayListId: selectedDayList.id,
            title: "Create Task in ${selectedDayList.title}",
          ),
        ),
      );
    }
  }

  Widget _buildBodyContent(List<DayList> dayLists) {
    bool isSomeDayListSelected = _selectedDayListIndex != null;

    if (isSomeDayListSelected) {
      final selectedDayList = dayLists[_selectedDayListIndex!];

      return TasksList(
        taskListId: selectedDayList.id,
        title: selectedDayList.title,
        tasks: selectedDayList.tasks,
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [const SizedBox(height: 20), ...getDayLists(dayLists)],
    );
  }

  @override
  Widget build(BuildContext context) {
    final dayLists = ref.watch(dayListsProvider);
    if (!_hasDayListForToday(dayLists)) {
      addTodayDayList();
    }
    return Scaffold(
      body: _buildBodyContent(dayLists),
      backgroundColor: Colors.transparent,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToNewTaskPage(),
        backgroundColor: Colors.amber[800],
        child: const Icon(Icons.add),
      ),
    );
  }
}
