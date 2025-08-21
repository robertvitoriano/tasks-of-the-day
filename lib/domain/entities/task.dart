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
  Task copyWith({
    String? id,
    String? dayListId,
    String? title,
    String? description,
    String? priority,
    String? category,
    DateTime? dueTime,
    bool? done,
  }) {
    return Task(
      id: id ?? this.id,
      dayListId: dayListId ?? this.dayListId,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      category: category ?? this.category,
      dueTime: dueTime ?? this.dueTime,
      done: done ?? this.done,
    );
  }
}
