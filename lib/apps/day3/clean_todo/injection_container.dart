import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/datasources/todo_local_datasource.dart';
import 'data/repositories/todo_repository_impl.dart';
import 'domain/repositories/todo_repository.dart';
import 'domain/usecases/get_todos.dart';
import 'domain/usecases/create_todo.dart';
import 'domain/usecases/toggle_todo.dart';
import 'domain/usecases/delete_todo.dart';
import 'presentation/bloc/todo_bloc.dart';

/// Q47: Dependency Injection Container
/// Manages all dependencies and their lifecycles
final sl = GetIt.instance;

Future<void> init() async {
  // ═══════════════════════════════════════════════════════════
  // PRESENTATION LAYER
  // ═══════════════════════════════════════════════════════════
  
  // BLoC
  sl.registerFactory(
    () => TodoBloc(
      getTodos: sl(),
      createTodo: sl(),
      toggleTodo: sl(),
      deleteTodo: sl(),
    ),
  );
  
  // ═══════════════════════════════════════════════════════════
  // DOMAIN LAYER - USE CASES
  // ═══════════════════════════════════════════════════════════
  
  sl.registerLazySingleton(() => GetTodos(sl()));
  sl.registerLazySingleton(() => CreateTodo(sl()));
  sl.registerLazySingleton(() => ToggleTodo(sl()));
  sl.registerLazySingleton(() => DeleteTodo(sl()));
  
  // ═══════════════════════════════════════════════════════════
  // DATA LAYER - REPOSITORIES
  // ═══════════════════════════════════════════════════════════
  
  sl.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(
      localDataSource: sl(),
    ),
  );
  
  // ═══════════════════════════════════════════════════════════
  // DATA LAYER - DATA SOURCES
  // ═══════════════════════════════════════════════════════════
  
  sl.registerLazySingleton<TodoLocalDataSource>(
    () => TodoLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );
  
  // ═══════════════════════════════════════════════════════════
  // EXTERNAL DEPENDENCIES
  // ═══════════════════════════════════════════════════════════
  
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}