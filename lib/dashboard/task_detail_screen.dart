import 'package:flutter/material.dart';
import 'package:minitaskhub/app/app_theme.dart';
import 'package:minitaskhub/dashboard/task_model.dart';
import 'package:minitaskhub/dashboard/task_provider.dart';
import 'package:provider/provider.dart';

class TaskDetailScreen extends StatelessWidget {
  final int taskId;

  const TaskDetailScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    final task = taskProvider.getTaskById(taskId)!;

    // Safety check
    if (task.id == -1) {
      return const Scaffold(
        body: Center(child: Text("Task not found")),
      );
    }

    final titleController = TextEditingController(text: task.title);
    final descController = TextEditingController(text: task.description);

    void updateTask() async {
      final updatedTask = Task(
        id: task.id,
        user_id: task.user_id,
        title: titleController.text,
        description: descController.text,
        isCompleted: true,
      );

      await Provider.of<TaskProvider>(context, listen: false).updateTaskDetail(updatedTask);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Task updated successfully")),
        );
        Navigator.pop(context); // optional: go back after saving
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Task Detail")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Task Name", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: titleController),
            const SizedBox(height: 20),

            const Text("Description", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(controller: descController, maxLines: 3),
            const SizedBox(height: 20),

            const Text("Status", style: TextStyle(fontWeight: FontWeight.bold)),
            Text(task.isCompleted ? "Completed" : "Pending", style: const TextStyle(fontSize: 18)),

            const Spacer(),

            SizedBox(
              width: double.infinity,
              child: MyButton(
                onPressed: updateTask,
                label: 'Mark as completed',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
