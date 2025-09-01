import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/domain/entities/day_list.dart';
import 'package:flutter_todo/domain/entities/task.dart';
import 'package:flutter_todo/domain/repositories/day_list_repository.dart';
import 'package:flutter_todo/providers/day_lists_repository_provider.dart';
import 'package:uuid/uuid.dart';

final _uuid = Uuid();

class DayListsNotifier extends Notifier<List<DayList>> {
  late final DayListRepository dayListRepository;

  @override
  List<DayList> build() {
    dayListRepository = ref.read(dayListsRepositoryProvider);
    return [];
  }

  void addTodayDayList() async {
    loadDayLists();
    final today = DateTime.now();
    final todayKey = today.toIso8601String().split('T')[0];

    final alreadyExists = state.any((list) => list.title == todayKey);

    if (!alreadyExists) {
      final dayList = DayList(
        id: _uuid.v4(),
        title: todayKey,
        tasks: [],
        date: today,
      );
      dayListRepository.storeDayList(dayList: dayList);
      state = [...state, dayList];
    }
  }

  void removeDayList(String id) {
    state = state.where((list) => list.id != id).toList();
  }

  Future<void> addTask({
    required String dayListId,
    required String title,
    required String description,
    required String category,
    required String priority,
    required DateTime dueTime,
  }) async {
    final dayListIndex = state.indexWhere((list) => list.id == dayListId);
    if (dayListIndex == -1) throw Error();
    final dayListToUpdate = state[dayListIndex];
    final dayListsWithNewTask = dayListToUpdate.copyWith(
      tasks: [
        ...dayListToUpdate.tasks,
        Task(
          id: _uuid.v4(),
          dayListId: dayListId,
          description: description,
          category: category,
          priority: priority,
          dueTime: dueTime,
          title: title,
          done: false,
        ),
      ],
    );
    await dayListRepository.storeDayList(dayList: dayListsWithNewTask);
    state = [
      ...state.sublist(0, dayListIndex),
      dayListsWithNewTask,
      ...state.sublist(dayListIndex + 1),
    ];
  }

  Future<void> toggleTask(String dayListId, String taskId) async {
    late final DayList dayListUpdated;
    state = state.map((list) {
      if (list.id == dayListId) {
        dayListUpdated = list.copyWith(
          tasks: list.tasks.map((task) {
            if (task.id == taskId) {
              return task.copyWith(done: !task.done);
            }
            return task;
          }).toList(),
        );
        return dayListUpdated;
      }
      return list;
    }).toList();
    await dayListRepository.storeDayList(dayList: dayListUpdated);
  }

  loadDayLists() {
    state = dayListRepository.getDayLists();
  }
}
