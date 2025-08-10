import 'package:flutter/material.dart';
import 'package:flutter_todo/presentation/pages/home.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const Home(title: 'Tasks of the day'),
  'completed':(context) => const Home(title: 'Tasks of the day'),
  '/profile': (context) => const Home(title: 'new home'),
  '/new-home': (context) => const Home(title: 'new home'),
};
