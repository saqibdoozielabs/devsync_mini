import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

class ToggleTodo implements UseCase<Todo, String> {
  final TodoRepository repository;
  
  ToggleTodo(this.repository);
  
  @override
  Future<Either<Failure, Todo>> call(String todoId) async {
    return await repository.toggleTodo(todoId);
  }
}