import 'package:flutter/material.dart';
import 'package:minitaskhub/app/app_theme.dart';
import 'package:minitaskhub/dashboard/task_model.dart';
import 'package:minitaskhub/services/supabase_service.dart';

class CreateTaskScreen extends StatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
  
  
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {

  final taskTitleController = TextEditingController();
  final taskDescriptionController = TextEditingController();
  final SupabaseService _supabaseService = SupabaseService();

  Future<void> createTask() async {
    final title = taskTitleController.text.trim();
    final description = taskDescriptionController.text.trim();

    if (title.isEmpty || description.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Title and Description cannot be empty")),
      );
      return;
    }

    final newTask = Task(
      id: 0, // Supabase will auto-generate this
      user_id: '', // Will be overridden in SupabaseService
      title: title,
      isCompleted: false,
      description: description,
    );

    try {
      await _supabaseService.createTask(newTask);
      if (mounted) {
        Navigator.pop(context); // Close screen after successful creation
      }
    } catch (e) {
      if(mounted){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to create task: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Create New Task")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Task Title"),
            MyTextField(
              label: "Task Title",
              controller: taskTitleController,
            ),
            const SizedBox(height: 12),
            const Text("Task Description"),
            MyTextField(
              label: "Enter your description here",
              controller: taskDescriptionController,
              maxlines: 5,
            ),
            const SizedBox(height: 12),
            //Create Task Button
            MyButton(
              label: "Create",
              onPressed: () {
                createTask(); 
              },
            ),
          ],
        ),
      ),
    );
  }
}
