import 'package:dartz/dartz.dart';
import '../error/failures.dart';

/// Q45: Base UseCase that all use cases extend
/// Type-safe way to handle success/failure
abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

/// For use cases that don't need parameters
class NoParams {}