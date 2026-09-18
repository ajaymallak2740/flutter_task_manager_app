import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String description;

  @HiveField(3)
  String priority; // low, medium, high

  @HiveField(4)
  DateTime dueDate;

  @HiveField(5)
  bool isDone;

  @HiveField(6)
  DateTime createdAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.dueDate,
    this.isDone = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  /// Create a copy of this task with some fields replaced
  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? priority,
    DateTime? dueDate,
    bool? isDone,
    DateTime? createdAt,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      dueDate: dueDate ?? this.dueDate,
      isDone: isDone ?? this.isDone,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'Task(id: $id, title: $title, priority: $priority, isDone: $isDone, dueDate: $dueDate)';
  }
}
