import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/usecases/usecase.dart';
import '../../domain/usecases/get_todos.dart';
import '../../domain/usecases/create_todo.dart';
import '../../domain/usecases/toggle_todo.dart';
import '../../domain/usecases/delete_todo.dart';
import 'todo_event.dart';
import 'todo_state.dart';

/// Q46: Presentation depends on Domain (use cases)
/// BLoC uses use cases, not repository directly
class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final GetTodos getTodos;
  final CreateTodo createTodo;
  final ToggleTodo toggleTodo;
  final DeleteTodo deleteTodo;
  
  TodoBloc({
    required this.getTodos,
    required this.createTodo,
    required this.toggleTodo,
    required this.deleteTodo,
  }) : super(TodoInitial()) {
    on<LoadTodosEvent>(_onLoadTodos);
    on<CreateTodoEvent>(_onCreateTodo);
    on<ToggleTodoEvent>(_onToggleTodo);
    on<DeleteTodoEvent>(_onDeleteTodo);
  }
  
  Future<void> _onLoadTodos(
    LoadTodosEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());
    
    // Q45: Call use case (business logic)
    final result = await getTodos(NoParams());
    
    // Q48: Handle Either<Failure, Success>
    result.fold(
      (failure) => emit(TodoError(failure.message)),
      (todos) => emit(TodoLoaded(todos)),
    );
  }
  
  Future<void> _onCreateTodo(
    CreateTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    emit(TodoLoading());
    
    final result = await createTodo(CreateTodoParams(
      title: event.title,
      description: event.description,
    ));
    
    result.fold(
      (failure) => emit(TodoError(failure.message)),
      (_) {
        // Reload todos after creation
        add(LoadTodosEvent());
      },
    );
  }
  
  Future<void> _onToggleTodo(
    ToggleTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    final result = await toggleTodo(event.todoId);
    
    result.fold(
      (failure) => emit(TodoError(failure.message)),
      (_) {
        // Reload todos after toggle
        add(LoadTodosEvent());
      },
    );
  }
  
  Future<void> _onDeleteTodo(
    DeleteTodoEvent event,
    Emitter<TodoState> emit,
  ) async {
    final result = await deleteTodo(event.todoId);
    
    result.fold(
      (failure) => emit(TodoError(failure.message)),
      (_) {
        // Reload todos after deletion
        add(LoadTodosEvent());
      },
    );
  }
}