import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/domain/entities/day_list.dart';
import 'package:flutter_todo/presentation/widgets/tasks_list.dart';
import 'package:flutter_todo/providers/tasks_provider.dart';
import 'package:go_router/go_router.dart';

class DayListPage extends ConsumerStatefulWidget {
  const DayListPage({super.key, required this.dayListId});

  final String dayListId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _DayListPage();
  }
}

class _DayListPage extends ConsumerState<DayListPage> {
  @override
  Widget build(BuildContext context) {
    final dayLists = ref.read(dayListsProvider);
    DayList selectedDayList = dayLists.firstWhere(
      (d) => d.id == widget.dayListId,
    );
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.go('/');
          },
        ),
      ),
      body: Column(
        children: [
          Center(
            child: Text(
              selectedDayList.title,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          TasksList(
            taskListId: selectedDayList.id,
            title: selectedDayList.title,
            tasks: selectedDayList.tasks,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/day-list/${selectedDayList.id}/new-task'),
        backgroundColor: Colors.amber[800],
        child: const Icon(Icons.add),
      ),
    );
  }
}
