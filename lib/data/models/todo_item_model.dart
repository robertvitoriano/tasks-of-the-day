import 'package:hive/hive.dart';

class TodoItemModel extends HiveObject {
  int id;
  String text;
  bool value;
  TodoItemModel({required this.id, required this.text, required this.value});
}
