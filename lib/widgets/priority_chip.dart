import 'package:flutter/material.dart';

class PriorityChip extends StatelessWidget {
  final String priority;
  final bool isSelected;
  final VoidCallback onTap;

  const PriorityChip({
    Key? key,
    required this.priority,
    this.isSelected = false,
    required this.onTap,
  }) : super(key: key);

  Color _getChipColor(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    if (!isSelected) {
      return isDark ? Colors.grey.shade700 : Colors.grey.shade200;
    }

    switch (priority.toLowerCase()) {
      case 'high':
        return Colors.red;
      case 'medium':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.blue;
    }
  }

  Color _getTextColor(BuildContext context) {
    if (!isSelected) {
      return Theme.of(context).brightness == Brightness.dark
          ? Colors.white
          : Colors.black;
    }
    return Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: _getChipColor(context),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          priority[0].toUpperCase() + priority.substring(1),
          style: TextStyle(
            color: _getTextColor(context),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
