    enum Priority { low, medium, high }

enum TaskStatus { pending, done }

class AppConstants {
  static const String appName = 'Task Manager';
  
  // Priority
  static const Map<Priority, String> priorityLabels = {
    Priority.low: 'Low',
    Priority.medium: 'Medium',
    Priority.high: 'High',
  };

  static const Map<Priority, int> priorityValues = {
    Priority.low: 0,
    Priority.medium: 1,
    Priority.high: 2,
  };

  // Task Status
  static const Map<TaskStatus, String> statusLabels = {
    TaskStatus.pending: 'Pending',
    TaskStatus.done: 'Done',
  };

  static Priority stringToPriority(String value) {
    return Priority.values.firstWhere(
      (p) => p.toString().split('.').last == value.toLowerCase(),
      orElse: () => Priority.low,
    );
  }

  static String priorityToString(Priority priority) {
    return priority.toString().split('.').last;
  }

  static TaskStatus stringToStatus(String value) {
    return TaskStatus.values.firstWhere(
      (s) => s.toString().split('.').last == value.toLowerCase(),
      orElse: () => TaskStatus.pending,
    );
  }

  static String statusToString(TaskStatus status) {
    return status.toString().split('.').last;
  }
}
