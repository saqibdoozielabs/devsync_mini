import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

/// Q45: Parameters for CreateTodo use case
class CreateTodoParams {
  final String title;
  final String description;
  
  CreateTodoParams({
    required this.title,
    required this.description,
  });
}

class CreateTodo implements UseCase<Todo, CreateTodoParams> {
  final TodoRepository repository;
  
  CreateTodo(this.repository);
  
  @override
  Future<Either<Failure, Todo>> call(CreateTodoParams params) async {
    // Q45: Business validation in use case
    if (params.title.trim().isEmpty) {
      return const Left(ValidationFailure('Title cannot be empty'));
    }
    
    if (params.title.length < 3) {
      return const Left(ValidationFailure('Title must be at least 3 characters'));
    }
    
    // Create entity
    final todo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: params.title.trim(),
      description: params.description.trim(),
      isCompleted: false,
      createdAt: DateTime.now(),
    );
    
    return await repository.createTodo(todo);
  }
}