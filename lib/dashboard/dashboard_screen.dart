import 'package:flutter/material.dart';
import 'package:minitaskhub/app/app_theme.dart';
import 'package:minitaskhub/dashboard/create_task_screen.dart';
import 'package:minitaskhub/dashboard/task_provider.dart';
import 'package:minitaskhub/dashboard/task_tile.dart';
import 'package:provider/provider.dart';

/*
    Make a list of task
    These tasks are retrieved from the DB
    Option to add task
    Delete task
    Mark task as completed
*/
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  void _navigateToCreateTask(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const CreateTaskScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DashboardAppBar(title: "Dashboard"),
      body: Consumer<TaskProvider>(
        builder: (context, taskProvider, child) {
          final tasks = taskProvider.tasks;

          if (tasks.isEmpty) {
            return const Center(child: Text("No tasks available"));
          }

          return RefreshIndicator(
            onRefresh: () => taskProvider.fetchTasks(),
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];
                return TaskTile(task: task);
              },
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 6.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () => _navigateToCreateTask(context),
              tooltip: 'Add Task',
            ),
          ],
        ),
      ),
    );
  }
}
