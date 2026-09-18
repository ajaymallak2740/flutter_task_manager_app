import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  final String taskId;
  final String title;
  final String description;
  final String priority;
  final DateTime dueDate;
  final bool isDone;
  final VoidCallback onTap;
  final VoidCallback onToggleDone;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TaskCard({
    Key? key,
    required this.taskId,
    required this.title,
    required this.description,
    required this.priority,
    required this.dueDate,
    required this.isDone,
    required this.onTap,
    required this.onToggleDone,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  String _getDaysUntil(DateTime dueDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final due = DateTime(dueDate.year, dueDate.month, dueDate.day);

    if (due.isBefore(today)) {
      return 'Overdue';
    } else if (due.isAtSameMomentAs(today)) {
      return 'Today';
    } else if (due.difference(today).inDays == 1) {
      return 'Tomorrow';
    } else {
      return 'In ${due.difference(today).inDays} days';
    }
  }

  Color _getPriorityColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    switch (priority.toLowerCase()) {
      case 'high':
        return isDark ? Colors.red.shade700 : Colors.red.shade100;
      case 'medium':
        return isDark ? Colors.orange.shade700 : Colors.orange.shade100;
      case 'low':
        return isDark ? Colors.green.shade700 : Colors.green.shade100;
      default:
        return isDark ? Colors.grey.shade700 : Colors.grey.shade100;
    }
  }

  Color _getPriorityTextColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    switch (priority.toLowerCase()) {
      case 'high':
        return isDark ? Colors.red.shade200 : Colors.red.shade700;
      case 'medium':
        return isDark ? Colors.orange.shade200 : Colors.orange.shade700;
      case 'low':
        return isDark ? Colors.green.shade200 : Colors.green.shade700;
      default:
        return isDark ? Colors.grey.shade300 : Colors.grey.shade700;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: InkWell(
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Checkbox
                  Checkbox(
                    value: isDone,
                    onChanged: (_) => onToggleDone(),
                  ),
                  // Title and Description
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                decoration: isDone
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (description.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4),
                            child: Text(
                              description,
                              style: Theme.of(context).textTheme.bodySmall,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                      ],
                    ),
                  ),
                  // Actions
                  PopupMenuButton(
                    itemBuilder: (context) => [
                      PopupMenuItem(
                        onTap: onEdit,
                        child: const Row(
                          children: [
                            Icon(Icons.edit, size: 18),
                            SizedBox(width: 8),
                            Text('Edit'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        onTap: onDelete,
                        child: const Row(
                          children: [
                            Icon(Icons.delete, size: 18, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Delete', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Priority and Due Date
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Priority Chip
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: _getPriorityColor(context),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      priority[0].toUpperCase() + priority.substring(1),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: _getPriorityTextColor(context),
                      ),
                    ),
                  ),
                  // Due Date
                  Text(
                    _getDaysUntil(dueDate),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
