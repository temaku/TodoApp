import 'todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

void main() {
  Bloc.observer = SimpleBLocObserver();
  final TodoRepository todoRepository = TodoRepository(dataProvider: TodoDataProvider(
    httpClient: http.Client()
  ));

  runApp(TodoApp(

  ));
}

class TodoApp extends StatelessWidget {
  final TodoRepository todoRepository;
  TodoApp({@required this.todoRepository}):assert(todoRepository != null);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: this.todoRepository,
      child:BlocProvider(
        create: (context) => TodoBloc(todoRepository: this.todoRepository)
            ..add(TodoLoad()),
    child:MaterialApp(
    title: 'Todo App',
      theme: ThemeData(
      primarySwatch: Colors.green,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: TodoAppRoute.generateRoute,
    )
    )
    );
  }
}

