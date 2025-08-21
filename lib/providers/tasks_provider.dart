import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/domain/entities/task.dart';

List<Task> allTasks = [
  Task(
    id: 1,
    dayListId: 1,
    title: 'teste task',
    category: 'home',
    description: 'new description',
    done: false,
    dueTime: DateTime(2025),
  ),
  Task(
    id: 2,
    dayListId: 1,
    title: 'teste task',
    category: 'home',
    description: 'new description',
    done: false,
    dueTime: DateTime(2025),
  ),
  Task(
    id: 3,
    dayListId: 1,
    title: 'teste task',
    category: 'home',
    description: 'new description',
    done: false,
    dueTime: DateTime(2025),
  ),
  Task(
    id: 4,
    dayListId: 1,
    title: 'teste task',
    category: 'leisure',
    description: 'new description',
    done: false,
    dueTime: DateTime(2025),
  ),
  Task(
    id: 5,
    dayListId: 1,
    title: 'teste task',
    category: 'leisure',
    description: 'new description',
    done: false,
    dueTime: DateTime(2025),
  ),
  Task(
    id: 6,
    dayListId: 1,
    title: 'teste task',
    category: 'leisure',
    description: 'new description',
    done: false,
    dueTime: DateTime(2025),
  ),
  Task(
    id: 7,
    dayListId: 1,
    title: 'teste task',
    category: 'leisure',
    description: 'new description',
    done: false,
    dueTime: DateTime(2025),
  ),
  Task(
    id: 8,
    dayListId: 1,
    title: 'teste task',
    category: 'leisure',
    description: 'new description',
    done: false,
    dueTime: DateTime(2025),
  ),
];
final allDayLists = [];
final tasksProvider = Provider((ref)=> allTasks);
final dayListsProvider = Provider((ref)=> allDayLists);

final hometasksProvider = Provider((ref)=>allTasks.where((t)=> t.category == 'home').toList());
