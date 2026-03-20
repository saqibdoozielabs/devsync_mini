import '../../domain/entities/todo.dart';

/// Q43: Model extends Entity
/// Model = Entity + JSON serialization
/// Model knows about data formats, Entity doesn't
class TodoModel extends Todo {
  const TodoModel({
    required super.id,
    required super.title,
    required super.description,
    required super.isCompleted,
    required super.createdAt,
  });
  
  /// Q43: From JSON (data layer concern)
  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      isCompleted: json['isCompleted'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }
  
  /// Q43: To JSON (data layer concern)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
      'createdAt': createdAt.toIso8601String(),
    };
  }
  
  /// Q43: From Entity (convert pure entity to model)
  factory TodoModel.fromEntity(Todo todo) {
    return TodoModel(
      id: todo.id,
      title: todo.title,
      description: todo.description,
      isCompleted: todo.isCompleted,
      createdAt: todo.createdAt,
    );
  }
  
  /// Q43: To Entity (model IS-A entity, so just return this)
  Todo toEntity() => this;
}