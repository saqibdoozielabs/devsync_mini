import 'package:dartz/dartz.dart';
import '../../../../../core/error/failures.dart';
import '../../../../../core/usecases/usecase.dart';
import '../repositories/todo_repository.dart';

class DeleteTodo implements UseCase<void, String> {
  final TodoRepository repository;
  
  DeleteTodo(this.repository);
  
  @override
  Future<Either<Failure, void>> call(String todoId) async {
    return await repository.deleteTodo(todoId);
  }
}