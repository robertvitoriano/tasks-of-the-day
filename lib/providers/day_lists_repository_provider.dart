import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/data/datasources/todo_lists_local_datasource.dart';
import 'package:flutter_todo/data/models/day_list_model.dart';
import 'package:flutter_todo/data/repositories/day_list_repository_impl.dart';
import 'package:flutter_todo/domain/repositories/day_list_repository.dart';
import 'package:hive/hive.dart';

final dayListsProvider = Provider<Box<DayListModel>>((ref) {
  throw UnimplementedError(); 
});

final dayListsRepositoryProvider = Provider<DayListRepository>((ref){
  final box = ref.watch(dayListsProvider);
  DayListsLocalDatasource dayListsLocalDatasource = DayListsLocalDatasource(box);
  return DayListRepositoryImpl(dayListsLocalDataSource: dayListsLocalDatasource);
});
