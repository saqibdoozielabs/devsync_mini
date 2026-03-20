import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/todo.dart';
import '../bloc/todo_bloc.dart';
import '../bloc/todo_event.dart';

class TodoListItem extends StatelessWidget {
  final Todo todo;
  
  const TodoListItem({
    Key? key,
    required this.todo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (_) {
            context.read<TodoBloc>().add(ToggleTodoEvent(todo.id));
          },
        ),
        
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted 
                ? TextDecoration.lineThrough 
                : null,
            color: todo.isCompleted ? Colors.grey : null,
          ),
        ),
        
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (todo.description.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                todo.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: todo.isCompleted ? Colors.grey : null,
                ),
              ),
            ],
            const SizedBox(height: 4),
            Text(
              todo.statusText,
              style: TextStyle(
                fontSize: 12,
                color: todo.isOverdue ? Colors.orange : Colors.grey,
              ),
            ),
          ],
        ),
        
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            context.read<TodoBloc>().add(DeleteTodoEvent(todo.id));
          },
        ),
      ),
    );
  }
}