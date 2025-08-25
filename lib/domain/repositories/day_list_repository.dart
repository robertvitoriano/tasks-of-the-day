import 'package:flutter_todo/domain/entities/day_list.dart';

abstract class DayListRepository {
  DayList? getDayList({required String id});
  List<DayList> getDayLists();
  Future<void> storeDayList({ required DayList dayList});
}
