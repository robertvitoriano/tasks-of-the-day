import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/domain/entities/day_list.dart';
import 'package:flutter_todo/domain/entities/task.dart';
import 'package:flutter_todo/notifiers/day_lists_notifier.dart';

final tasksProvider = StateProvider<List<Task>>((ref) => []);

final dayListsProvider =
    NotifierProvider<DayListsNotifier, List<DayList>>(DayListsNotifier.new);
    




