import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/domain/entities/day_list.dart';
import 'package:flutter_todo/providers/day_lists_provider_provider.dart';
import 'package:go_router/go_router.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final dayLists = ref.read(dayListsProvider);
      if (!_hasDayListForToday(dayLists)) {
        ref.read(dayListsProvider.notifier).addTodayDayList();
      }
    });
  }

  void selectDayList(String dayListId) {
    context.go('/day-list/$dayListId');
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
          onTap: () => selectDayList(dayLists[i].id),
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

  @override
  Widget build(BuildContext context) {
    final dayLists = ref.watch(dayListsProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [const SizedBox(height: 20), ...getDayLists(dayLists)],
        ),
      ),
      backgroundColor: Colors.transparent,
    );
  }
}
