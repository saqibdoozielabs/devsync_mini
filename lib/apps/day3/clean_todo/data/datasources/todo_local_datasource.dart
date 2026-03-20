import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../../../../core/error/exceptions.dart';
import '../models/todo_model.dart';

/// Q44: Data Source - Where data comes from
/// This one uses SharedPreferences (local storage)
abstract class TodoLocalDataSource {
  Future<List<TodoModel>> getCachedTodos();
  Future<void> cacheTodos(List<TodoModel> todos);
  Future<void> cacheTodo(TodoModel todo);
  Future<void> deleteTodo(String id);
}

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  final SharedPreferences sharedPreferences;
  
  static const CACHED_TODOS = 'CACHED_TODOS';
  
  TodoLocalDataSourceImpl({required this.sharedPreferences});
  
  @override
  Future<List<TodoModel>> getCachedTodos() async {
    try {
      final jsonString = sharedPreferences.getString(CACHED_TODOS);
      
      if (jsonString != null) {
        final List<dynamic> jsonList = json.decode(jsonString);
        return jsonList.map((json) => TodoModel.fromJson(json)).toList();
      } else {
        return [];
      }
    } catch (e) {
      throw CacheException('Failed to get cached todos');
    }
  }
  
  @override
  Future<void> cacheTodos(List<TodoModel> todos) async {
    try {
      final jsonList = todos.map((todo) => todo.toJson()).toList();
      final jsonString = json.encode(jsonList);
      await sharedPreferences.setString(CACHED_TODOS, jsonString);
    } catch (e) {
      throw CacheException('Failed to cache todos');
    }
  }
  
  @override
  Future<void> cacheTodo(TodoModel todo) async {
    try {
      final todos = await getCachedTodos();
      
      // Check if todo exists
      final index = todos.indexWhere((t) => t.id == todo.id);
      
      if (index != -1) {
        // Update existing
        todos[index] = todo;
      } else {
        // Add new
        todos.add(todo);
      }
      
      await cacheTodos(todos);
    } catch (e) {
      throw CacheException('Failed to cache todo');
    }
  }
  
  @override
  Future<void> deleteTodo(String id) async {
    try {
      final todos = await getCachedTodos();
      todos.removeWhere((todo) => todo.id == id);
      await cacheTodos(todos);
    } catch (e) {
      throw CacheException('Failed to delete todo');
    }
  }
}