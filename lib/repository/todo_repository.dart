import 'dart:async';

import 'package:TodoApp/data_provider/todo_data_provider.dart';
import 'package:meta/meta.dart';
import '../model/todo.dart';

class TodoRepository {
  final TodoDataProvider dataProvider;

  TodoRepository({@required this.dataProvider}) :assert(dataProvider != null);

  Future<Todo> createTodo(Todo todo) async {
    return await dataProvider.createCourse(todo);
  }

  Future<List<Todo>> getTodos() async {
    return await dataProvider.getTodos();
  }

  Future<void> updateTodo(Todo todo) async {
    return await dataProvider.updateTodos();
  }

  Future<void> deleteTodo(String id) {
    return await dataProvider.deleteTodo(id);
  }

}
