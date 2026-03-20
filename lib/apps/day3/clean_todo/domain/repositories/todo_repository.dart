import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../entities/todo.dart';

/// Q44: Repository Pattern - Abstract contract
/// Domain layer defines WHAT, Data layer defines HOW
/// This is the "contract" that data layer must implement
abstract class TodoRepository {
  /// Get all todos
  /// Q48: Returns Either<Failure, List<Todo>>
  /// Left = Failure, Right = Success
  Future<Either<Failure, List<Todo>>> getTodos();
  
  /// Get single todo by ID
  Future<Either<Failure, Todo>> getTodoById(String id);
  
  /// Create new todo
  Future<Either<Failure, Todo>> createTodo(Todo todo);
  
  /// Update existing todo
  Future<Either<Failure, Todo>> updateTodo(Todo todo);
  
  /// Delete todo
  Future<Either<Failure, void>> deleteTodo(String id);
  
  /// Toggle completion status
  Future<Either<Failure, Todo>> toggleTodo(String id);
}