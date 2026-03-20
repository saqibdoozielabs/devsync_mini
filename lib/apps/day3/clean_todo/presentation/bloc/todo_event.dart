import 'package:equatable/equatable.dart';

abstract class TodoEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadTodosEvent extends TodoEvent {}

class CreateTodoEvent extends TodoEvent {
  final String title;
  final String description;
  
  CreateTodoEvent({
    required this.title,
    required this.description,
  });
  
  @override
  List<Object?> get props => [title, description];
}

class ToggleTodoEvent extends TodoEvent {
  final String todoId;
  
  ToggleTodoEvent(this.todoId);
  
  @override
  List<Object?> get props => [todoId];
}

class DeleteTodoEvent extends TodoEvent {
  final String todoId;
  
  DeleteTodoEvent(this.todoId);
  
  @override
  List<Object?> get props => [todoId];
}