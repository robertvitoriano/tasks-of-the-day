import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_todo/data/models/task_model.dart';
import 'package:flutter_todo/data/models/day_list_model.dart';
import 'package:flutter_todo/presentation/pages/day_list_page.dart';
import 'package:flutter_todo/presentation/pages/layout/layout_page.dart';
import 'package:flutter_todo/presentation/pages/new_task_page.dart';
import 'package:flutter_todo/providers/day_lists_repository_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_todo/extensions/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (!kIsWeb) {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    Hive.registerAdapter(TaskModelAdapter());
    Hive.registerAdapter(DayListModelAdapter());
  }
  final box = await Hive.openBox<DayListModel>('day_lists');

  runApp(
    ProviderScope(
      overrides: [dayListsProvider.overrideWithValue(box)],
      child: const MyApp(),
    ),
  );
}

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) {
        return Layout();
      },
    ),
    GoRoute(
      path: '/day-list/:dayListId/new-task',
      builder: (context, state) {
        final dayListId = state.pathParameters['dayListId']!;
        return NewTask(dayListId: dayListId, title: 'Dynamic');
      },
    ),
    GoRoute(
      path: '/day-list/:dayListId',
      builder: (context, state) {
        final dayListId = state.pathParameters['dayListId']!;
        return DayListPage(dayListId: dayListId);
      },
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      color: "#E5FCEF".toColor(),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: "#E5FCEF".toColor()),
      ),
      routerConfig: router,
    );
  }
}
