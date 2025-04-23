//model class for the Task Object
class Task {
  final int id;
  final String user_id;
  final String title;
  final bool isCompleted;
  final String description;

  Task({
    required this.id,
    required this.user_id,
    required this.title,
    required this.isCompleted,
    required this.description,
  });

  // map -> task
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as int,
      user_id: map['user_id'] as String,
      title: map['title'] ?? '',
      description: map['description'] ?? '',      
      isCompleted: map['is_completed'] ?? false,
    );
  }

  // task -> map
   Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id':user_id,
      'title': title,
      'description': description,
      'is_completed': isCompleted,
    };
  }
  
}
