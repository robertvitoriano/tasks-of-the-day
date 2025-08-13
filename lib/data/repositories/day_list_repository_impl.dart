import 'package:flutter_todo/data/datasources/todo_lists_local_datasource.dart';
import 'package:flutter_todo/data/mappers/day_list_entity_mapper.dart';
import 'package:flutter_todo/data/mappers/day_list_model_mapper.dart';
import 'package:flutter_todo/domain/entities/day_list.dart';
import 'package:flutter_todo/domain/repositories/day_list_repository.dart';

class DayListRepositoryImpl implements DayListRepository {
  DayListRepositoryImpl({required this.dayListsLocalDataSource});

  final DayListsLocalDatasource dayListsLocalDataSource;

  @override
  DayList? getDayList({required String id}) {
    final dayListModel = dayListsLocalDataSource.getDayList(key: id);

    return dayListModel?.toEntity();
  }

  @override
  Future<void> storeDayList({
    required String id,
    required DayList dayList,
  }) async {
    await dayListsLocalDataSource.saveTodo(key: id, dayList: dayList.toModel());
  }
}
