import 'package:flutter/material.dart';
import 'package:minitaskhub/dashboard/task_detail_screen.dart';
import 'package:minitaskhub/dashboard/task_model.dart';
import 'package:minitaskhub/dashboard/task_provider.dart';
import 'package:provider/provider.dart';

class TaskTile extends StatefulWidget {
  final Task task;

  const TaskTile({
    super.key,
    required this.task,
  });

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  late bool isCompleted;

  @override
  void initState() {
    super.initState();
    isCompleted = widget.task.isCompleted;
  }

   @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.task.title),
      subtitle: Text(widget.task.description),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => TaskDetailScreen(taskId: widget.task.id),
          ),
        );
      },
      trailing: Checkbox(
        value: isCompleted,
        onChanged: (bool? newValue) async {
          final updatedValue = newValue ?? false;

          setState(() {
            isCompleted = updatedValue;
          });

          try {
            await Provider.of<TaskProvider>(context, listen: false)
                .updateTaskCompletion(widget.task.id, updatedValue);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Task updated')),
              );            
          } catch (e) {

            setState(() {
              isCompleted = !updatedValue;
            });

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Failed to update task")),
            );
          }
        },
      ),
    );
  }
}
