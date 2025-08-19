import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/domain/entities/task.dart';

List<Task> allTasks = [
  Task(
    id: 1,
    title: 'teste task',
    category: 'home',
    description: 'new description',
    done: false,
    dueTime: DateTime(2025),
  ),
    Task(
    id: 2,
    title: 'teste task',
    category: 'home',
    description: 'new description',
    done: false,
    dueTime: DateTime(2025),
  ),
    Task(
    id: 3,
    title: 'teste task',
    category: 'home',
    description: 'new description',
    done: false,
    dueTime: DateTime(2025),
  ),
    Task(
    id: 4,
    title: 'teste task',
    category: 'leisure',
    description: 'new description',
    done: false,
    dueTime: DateTime(2025),
  ),
    Task(
    id: 5,
    title: 'teste task',
    category: 'leisure',
    description: 'new description',
    done: false,
    dueTime: DateTime(2025),
  ),
    Task(
    id: 6,
    title: 'teste task',
    category: 'leisure',
    description: 'new description',
    done: false,
    dueTime: DateTime(2025),
  ),
    Task(
    id: 7,
    title: 'teste task',
    category: 'leisure',
    description: 'new description',
    done: false,
    dueTime: DateTime(2025),
  ),
    Task(
    id: 8,
    title: 'teste task',
    category: 'leisure',
    description: 'new description',
    done: false,
    dueTime: DateTime(2025),
  ),
];

final tasksProvider = Provider((ref)=> allTasks);

final hometasksProvider = Provider((ref)=>allTasks.where((t)=> t.category == 'home').toList());
