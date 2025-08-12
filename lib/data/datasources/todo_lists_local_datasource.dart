import 'package:flutter_todo/data/models/day_list_model.dart';
import 'package:hive/hive.dart';

class DayListsLocalDatasource {
  final Box<DayListModel> box;

  DayListsLocalDatasource(this.box);
  Future<void> saveTodo({
    required String key,
    required DayListModel dayList,
  }) async {
    await box.put(key, dayList);
  }

  DayListModel? getDayList({required String key}) {
    final dayList = box.get(key);

    if (dayList == null) return null;

    return dayList;
  }
}
