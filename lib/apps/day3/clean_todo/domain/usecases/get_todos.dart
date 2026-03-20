import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../entities/todo.dart';
import '../repositories/todo_repository.dart';

/// Q45: Use Case - Single business action
/// Each use case does ONE thing
/// Encapsulates business rules
class GetTodos implements UseCase<List<Todo>, NoParams> {
  final TodoRepository repository;
  
  GetTodos(this.repository);
  
  @override
  Future<Either<Failure, List<Todo>>> call(NoParams params) async {
    // Q45: Can add business logic here
    // Example: Filter, sort, validate, etc.
    
    final result = await repository.getTodos();
    
    // Q45: Business rule - sort by creation date
    return result.fold(
      (failure) => Left(failure),
      (todos) {
        final sortedTodos = List<Todo>.from(todos)
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
        return Right(sortedTodos);
      },
    );
  }
}