import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/domain/entities/day_list.dart';
import 'package:flutter_todo/domain/entities/task.dart';
import 'package:uuid/uuid.dart';

final _uuid = Uuid();

class DayListsNotifier extends Notifier<List<DayList>> {


  @override
  List<DayList> build() {
    return [];
  }

  void addTodayDayList() {
    state = [
      ...state,
      DayList(
        id: _uuid.v4(),
        title: DateTime.now().toIso8601String().split('T')[0],
        tasks: [],
        date: DateTime.now(),
      ),
    ];
  }

  void removeDayList(String id) {
    state = state.where((list) => list.id != id).toList();
  }

  void addTask(String dayListId, String taskTitle) {
    state = state.map((list) {
      if (list.id == dayListId) {
        return list.copyWith(
          tasks: [
            ...list.tasks,
            Task(
              id: _uuid.v4(),
              dayListId: dayListId,
              title: taskTitle,
              done: false,
            ),
          ],
        );
      }
      return list;
    }).toList();
  }

  void toggleTask(String dayListId, String taskId) {
    state = state.map((list) {
      if (list.id == dayListId) {
        return list.copyWith(
          tasks: list.tasks.map((task) {
            if (task.id == taskId) {
              return task.copyWith(done: !task.done);
            }
            return task;
          }).toList(),
        );
      }
      return list;
    }).toList();
  }
}
