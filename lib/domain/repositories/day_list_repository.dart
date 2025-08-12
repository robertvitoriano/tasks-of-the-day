import 'package:flutter_todo/domain/entities/day_list.dart';

abstract class DayListRepository {
  DayList? getDayList({required String id});

  Future<void> storeDayList({required String id, required DayList dayList});
}
