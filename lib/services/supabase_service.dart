import 'package:minitaskhub/dashboard/task_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  final supabase = Supabase.instance.client;

  // Fetch Task
  Future<List<Task>> fetchTasks() async {
    final userId = supabase.auth.currentUser?.id;

    if (userId == null) {
      throw Exception("User not logged in");
    }

    final response = await supabase
        .from('Tasks')
        .select()
        .eq('user_id', userId);

    return (response as List)
        .map((e) => Task.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  // Create Task
  Future<void> createTask(Task task) async {
    final userId = supabase.auth.currentUser?.id;
    if (userId == null) throw Exception("User not logged in");

    await supabase.from('Tasks').insert({
      'user_id': userId,
      'title': task.title,
      'description': task.description,
      'is_completed': task.isCompleted,
    });
  }

  // Update Task
  Future<void> updateTask(Task task) async {
    await supabase
        .from('Tasks')
        .update({
          'title': task.title,
          'description': task.description,
          'is_completed': task.isCompleted,
        })
        .eq('id', task.id);
  }

  // Delete task
  Future<void> deleteTask(int taskId) async {
    await supabase.from('Tasks').delete().eq('id', taskId);
  }
}

