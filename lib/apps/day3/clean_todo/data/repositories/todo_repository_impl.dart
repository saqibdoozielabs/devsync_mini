import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/error/exceptions.dart';
import '../../domain/entities/todo.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_local_datasource.dart';
import '../models/todo_model.dart';

/// Q44: Repository Implementation
/// Implements the contract defined in domain layer
/// Handles data sources and error conversion
class TodoRepositoryImpl implements TodoRepository {
  final TodoLocalDataSource localDataSource;
  
  TodoRepositoryImpl({
    required this.localDataSource,
  });
  
  @override
  Future<Either<Failure, List<Todo>>> getTodos() async {
    try {
      // Q44: Get data from data source
      final todos = await localDataSource.getCachedTodos();
      
      // Q44: Convert models to entities
      return Right(todos);
    } on CacheException catch (e) {
      // Q48: Convert exception to failure
      return Left(CacheFailure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, Todo>> getTodoById(String id) async {
    try {
      final todos = await localDataSource.getCachedTodos();
      final todo = todos.firstWhere(
        (todo) => todo.id == id,
        orElse: () => throw CacheException('Todo not found'),
      );
      return Right(todo);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, Todo>> createTodo(Todo todo) async {
    try {
      // Q43: Convert entity to model
      final todoModel = TodoModel.fromEntity(todo);
      
      // Q44: Save to data source
      await localDataSource.cacheTodo(todoModel);
      
      return Right(todoModel);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, Todo>> updateTodo(Todo todo) async {
    try {
      final todoModel = TodoModel.fromEntity(todo);
      await localDataSource.cacheTodo(todoModel);
      return Right(todoModel);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, void>> deleteTodo(String id) async {
    try {
      await localDataSource.deleteTodo(id);
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
  
  @override
  Future<Either<Failure, Todo>> toggleTodo(String id) async {
    try {
      // Get current todo
      final todosResult = await getTodos();
      
      return todosResult.fold(
        (failure) => Left(failure),
        (todos) async {
          final todo = todos.firstWhere(
            (t) => t.id == id,
            orElse: () => throw CacheException('Todo not found'),
          );
          
          // Toggle completion
          final updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);
          
          // Save
          return await updateTodo(updatedTodo);
        },
      );
    } on CacheException catch (e) {
      return Left(CacheFailure(e.message));
    }
  }
}