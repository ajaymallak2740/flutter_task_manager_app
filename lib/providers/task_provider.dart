import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/task_model.dart';
import '../services/hive_service.dart';
import '../utils/constants.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _allTasks = [];
  String _searchQuery = '';
  String? _filterStatus; // 'pending', 'done', null for all
  String? _filterPriority; // 'low', 'medium', 'high', null for all

  /// Constructor - loads tasks from Hive
  TaskProvider() {
    loadTasks();
  }

  /// Get all tasks
  List<Task> get allTasks => _allTasks;

  /// Get filtered and searched tasks
  List<Task> get filteredTasks {
    var result = _allTasks.toList();

    // Apply status filter
    if (_filterStatus != null && _filterStatus!.isNotEmpty) {
      result = result.where((task) {
        if (_filterStatus == 'done') {
          return task.isDone;
        } else if (_filterStatus == 'pending') {
          return !task.isDone;
        }
        return true;
      }).toList();
    }

    // Apply priority filter
    if (_filterPriority != null && _filterPriority!.isNotEmpty) {
      result = result.where((task) => task.priority == _filterPriority).toList();
    }

    // Apply search filter
    if (_searchQuery.isNotEmpty) {
      result = result
          .where((task) =>
              task.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              task.description.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    // Sort by due date
    result.sort((a, b) => a.dueDate.compareTo(b.dueDate));

    return result;
  }

  /// Load all tasks from Hive
  void loadTasks() {
    _allTasks.clear();
    final tasks = HiveService.getAllTasks();
    _allTasks.addAll(tasks);
    notifyListeners();
  }

  /// Add a new task
  Future<void> addTask({
    required String title,
    required String description,
    required String priority,
    required DateTime dueDate,
  }) async {
    const uuid = Uuid();
    final task = Task(
      id: uuid.v4(),
      title: title,
      description: description,
      priority: priority,
      dueDate: dueDate,
    );

    _allTasks.add(task);
    await HiveService.addTask(task);
    notifyListeners();
  }

  /// Update an existing task
  Future<void> updateTask({
    required String id,
    required String title,
    required String description,
    required String priority,
    required DateTime dueDate,
  }) async {
    final index = _allTasks.indexWhere((task) => task.id == id);
    if (index >= 0) {
      _allTasks[index] = _allTasks[index].copyWith(
        title: title,
        description: description,
        priority: priority,
        dueDate: dueDate,
      );
      await HiveService.updateTask(_allTasks[index]);
      notifyListeners();
    }
  }

  /// Delete a task
  Future<void> deleteTask(String taskId) async {
    _allTasks.removeWhere((task) => task.id == taskId);
    await HiveService.deleteTask(taskId);
    notifyListeners();
  }

  /// Toggle task completion status
  Future<void> toggleTaskDone(String taskId) async {
    final index = _allTasks.indexWhere((task) => task.id == taskId);
    if (index >= 0) {
      _allTasks[index] =
          _allTasks[index].copyWith(isDone: !_allTasks[index].isDone);
      await HiveService.updateTask(_allTasks[index]);
      notifyListeners();
    }
  }

  /// Search tasks by title or description
  void searchTasks(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  /// Filter tasks by status
  void filterByStatus(String? status) {
    _filterStatus = status;
    notifyListeners();
  }

  /// Filter tasks by priority
  void filterByPriority(String? priority) {
    _filterPriority = priority;
    notifyListeners();
  }

  /// Clear all filters
  void clearFilters() {
    _searchQuery = '';
    _filterStatus = null;
    _filterPriority = null;
    notifyListeners();
  }

  /// Get task by ID
  Task? getTaskById(String taskId) {
    try {
      return _allTasks.firstWhere((task) => task.id == taskId);
    } catch (e) {
      return null;
    }
  }

  /// Get task count
  int get taskCount => _allTasks.length;

  /// Get pending task count
  int get pendingCount => _allTasks.where((task) => !task.isDone).length;

  /// Get completed task count
  int get completedCount => _allTasks.where((task) => task.isDone).length;
}
