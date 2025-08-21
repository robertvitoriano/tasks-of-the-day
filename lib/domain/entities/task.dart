class Task {
  String id;
  String dayListId;
  String title;
  String description;
  String priority;
  String category;
  DateTime dueTime;
  bool done;
  Task({
    required this.id,
    required this.dayListId,
    required this.title,
    this.done = false,
    this.description = "",
    this.priority = "",
    this.category = "",
    DateTime? dueTime,
  }) : dueTime = dueTime ?? DateTime.now().add(const Duration(hours: 5));
}
