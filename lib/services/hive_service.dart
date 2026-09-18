import 'package:hive_flutter/hive_flutter.dart';
import '../models/task_model.dart';

class HiveService {
  static const String tasksBoxName = 'tasks';
  static late Box<Task> _tasksBox;

  /// Initialize Hive and open the tasks box
  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Register adapters
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(TaskAdapter());
    }

    // Open the tasks box
    _tasksBox = await Hive.openBox<Task>(tasksBoxName);
  }

  /// Get the tasks box
  static Box<Task> getTasksBox() {
    return _tasksBox;
  }

  /// Get all tasks from the box
  static List<Task> getAllTasks() {
    return _tasksBox.values.toList();
  }

  /// Add a task to the box
  static Future<void> addTask(Task task) async {
    await _tasksBox.put(task.id, task);
  }

  /// Update a task in the box
  static Future<void> updateTask(Task task) async {
    await _tasksBox.put(task.id, task);
  }

  /// Delete a task from the box
  static Future<void> deleteTask(String taskId) async {
    await _tasksBox.delete(taskId);
  }

  /// Clear all tasks
  static Future<void> clearAllTasks() async {
    await _tasksBox.clear();
  }

  /// Close the box and Hive
  static Future<void> close() async {
    await Hive.close();
  }
}
