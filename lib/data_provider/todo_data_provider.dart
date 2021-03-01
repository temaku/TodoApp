import 'dart:convert';

import 'package:meta/meta.dart';
import '../model/todo.dart';
import 'package:http/http.dart' as http;

class TodoDataProvider {
  final _baseUrl = 'http://192.168.56.1:3000';
  final http.Client httpClient;

  TodoDataProvider({@required this.httpClient}) : assert(httpClient != null);

  Future<Todo> createTodo(Todo todo) async {
    final response = await httpClient.post(
      Uri.http('192.168.56.1:3000', '/todos'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'id':todo.id,
        'title': todo.title,
        'description': todo.description,
        'dateCreated': todo.dateCreated,
        'done': todo.done,
      }),
    );

    if (response.statusCode == 200) {
      return Todo.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create course.');
    }
  }

  Future<List<Todo>> getTodos() async {
    final response = await httpClient.get('$_baseUrl/courses');

    if (response.statusCode == 200) {
      final todos = jsonDecode(response.body) as List;
      return todos.map((todo) => Todo.fromJson(todo)).toList();
    } else {
      throw Exception('Failed to load courses');
    }
  }

  Future<void> deleteTodos(String id) async {
    final http.Response response = await httpClient.delete(
      '$_baseUrl/todo/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to delete course.');
    }
  }

  Future<void> updateTodos(Todo todo) async {
    final http.Response response = await httpClient.put(
      '$_baseUrl/courses/${todo.id}',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
         'id':todo.id,
        'title': todo.title,
        'description': todo.description,
        'dateCreated': todo.dateCreated,
        'done': todo.done,
      }),
    );

    if (response.statusCode != 204) {
      throw Exception('Failed to update course.');
    }
  }
}