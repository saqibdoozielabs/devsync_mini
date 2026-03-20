import 'package:equatable/equatable.dart';

/// Q43: Entity - Pure business object
/// No JSON, no database code - just business logic
/// This is what your app ACTUALLY works with
class Todo extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isCompleted;
  final DateTime createdAt;
  
  const Todo({
    required this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.createdAt,
  });
  
  /// Q43: Entities can have business logic
  bool get isOverdue {
    final daysSinceCreation = DateTime.now().difference(createdAt).inDays;
    return !isCompleted && daysSinceCreation > 7;
  }
  
  String get statusText {
    if (isCompleted) return 'Done ✅';
    if (isOverdue) return 'Overdue ⚠️';
    return 'Pending 📝';
  }
  
  /// Q43: Pure business logic method
  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }
  
  @override
  List<Object?> get props => [id, title, description, isCompleted, createdAt];
}