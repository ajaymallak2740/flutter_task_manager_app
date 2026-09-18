import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/task_card.dart';
import 'add_edit_task_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        elevation: 0,
        actions: [
          // Theme toggle
          IconButton(
            icon: Icon(
              Provider.of<ThemeProvider>(context).isDarkMode
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search tasks...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          Provider.of<TaskProvider>(context, listen: false)
                              .searchTasks('');
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (value) {
                Provider.of<TaskProvider>(context, listen: false)
                    .searchTasks(value);
                setState(() {});
              },
            ),
          ),
          // Filter chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Consumer<TaskProvider>(
                builder: (context, taskProvider, _) {
                  return Row(
                    children: [
                      // All filter
                      _FilterChip(
                        label: 'All',
                        isSelected: taskProvider._filterStatus == null &&
                            taskProvider._filterPriority == null,
                        onTap: () {
                          taskProvider.clearFilters();
                        },
                      ),
                      const SizedBox(width: 8),
                      // Pending filter
                      _FilterChip(
                        label: 'Pending',
                        isSelected: taskProvider._filterStatus == 'pending',
                        onTap: () {
                          if (taskProvider._filterStatus == 'pending') {
                            taskProvider.filterByStatus(null);
                          } else {
                            taskProvider.filterByStatus('pending');
                            taskProvider.filterByPriority(null);
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                      // Done filter
                      _FilterChip(
                        label: 'Done',
                        isSelected: taskProvider._filterStatus == 'done',
                        onTap: () {
                          if (taskProvider._filterStatus == 'done') {
                            taskProvider.filterByStatus(null);
                          } else {
                            taskProvider.filterByStatus('done');
                            taskProvider.filterByPriority(null);
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                      // Priority filters
                      _FilterChip(
                        label: 'High',
                        isSelected: taskProvider._filterPriority == 'high',
                        onTap: () {
                          if (taskProvider._filterPriority == 'high') {
                            taskProvider.filterByPriority(null);
                          } else {
                            taskProvider.filterByPriority('high');
                            taskProvider.filterByStatus(null);
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        label: 'Medium',
                        isSelected: taskProvider._filterPriority == 'medium',
                        onTap: () {
                          if (taskProvider._filterPriority == 'medium') {
                            taskProvider.filterByPriority(null);
                          } else {
                            taskProvider.filterByPriority('medium');
                            taskProvider.filterByStatus(null);
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                      _FilterChip(
                        label: 'Low',
                        isSelected: taskProvider._filterPriority == 'low',
                        onTap: () {
                          if (taskProvider._filterPriority == 'low') {
                            taskProvider.filterByPriority(null);
                          } else {
                            taskProvider.filterByPriority('low');
                            taskProvider.filterByStatus(null);
                          }
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Tasks list
          Expanded(
            child: Consumer<TaskProvider>(
              builder: (context, taskProvider, _) {
                final tasks = taskProvider.filteredTasks;

                if (tasks.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.task_alt_outlined,
                          size: 64,
                          color: Colors.grey.shade400,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No tasks yet',
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Create your first task to get started',
                          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return TaskCard(
                      taskId: task.id,
                      title: task.title,
                      description: task.description,
                      priority: task.priority,
                      dueDate: task.dueDate,
                      isDone: task.isDone,
                      onTap: () {},
                      onToggleDone: () {
                        taskProvider.toggleTaskDone(task.id);
                      },
                      onEdit: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                AddEditTaskScreen(taskId: task.id),
                          ),
                        );
                      },
                      onDelete: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text('Task deleted'),
                            action: SnackBarAction(
                              label: 'Undo',
                              onPressed: () {
                                // Re-add the task (simplified for demo)
                              },
                            ),
                          ),
                        );
                        taskProvider.deleteTask(task.id);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddEditTaskScreen(),
            ),
          );
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
