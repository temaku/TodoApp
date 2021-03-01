import 'package:TodoApp/pages/todo_add_update.dart';
import 'package:TodoApp/pages/todo_detail.dart';
import 'package:TodoApp/pages/todo_list.dart';
import 'package:flutter/material.dart';
import '../model/todo.dart';
class TodoAppRoute{
  static Route generateRoute(RouteSettings settings){
    if(settings.name == '/'){
      return MaterialPageRoute(builder: (context)=>TodoList());

    }
    if(settings.name == AddUpdateTodo.routeName){
      TodoArguments args = settings.arguments;
      return MaterialPageRoute(
          builder: (context)=>AddUpdateTodo(args:args));

    }
    if(settings.name == TodoDetail.routeName){
      Todo todo = settings.arguments;
      return MaterialPageRoute(builder:
      (context)=> TodoDetail(todo: todo));
    }
    return MaterialPageRoute(builder: (context)=>TodoList());
  }

}
class TodoArguments{
  final Todo todo;
  final bool edit;
  TodoArguments({this.todo,this.edit});
}