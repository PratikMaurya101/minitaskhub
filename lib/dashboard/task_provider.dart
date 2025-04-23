import 'package:flutter/material.dart';
import 'package:minitaskhub/services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'task_model.dart';

class TaskProvider extends ChangeNotifier {
  final List<Task> _tasks = [];
  final SupabaseService _supabaseService = SupabaseService();

  List<Task> get tasks => _tasks;

  Future<void> fetchTasks() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    final response = await Supabase.instance.client
        .from('Tasks')
        .select()
        .eq('user_id', userId!);

    print("response from supabase: $response");

    _tasks.clear();
    _tasks.addAll((response as List).map((e) => Task.fromMap(e)).toList());
    notifyListeners();
  }

  // Update the isComplete status
  Future<void> updateTaskCompletion(int taskId, bool isCompleted) async {
    try {
      final index = _tasks.indexWhere((task) => task.id == taskId);
      if (index == -1) return;

      final updatedTask = Task(
        id: _tasks[index].id,
        user_id: _tasks[index].user_id,
        title: _tasks[index].title,
        description: _tasks[index].description,
        isCompleted: isCompleted,
      );

      await _supabaseService.updateTask(updatedTask);
      _tasks[index] = updatedTask;
      notifyListeners();
    } catch (e) {
      print('Error updating task: $e');
      rethrow;
    }
  }

  // Updates the task status from task_detail_screen
  Future<void> updateTaskDetail(Task updatedTask) async {
  await SupabaseService().updateTask(updatedTask);

  final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
  if (index != -1) {
    _tasks[index] = updatedTask;
    notifyListeners();
  }
}


  Task? getTaskById(int id) {
    return _tasks.firstWhere(
      (task) => task.id == id, 
      orElse: () => Task(                  //when no task is found
        id: -1,
        user_id: '',
        title: "unknown",
        isCompleted: false, 
        description: "no description found"
      ),
    );
  }
}