import 'package:TodoApp/bloc/todo_event.dart';
import 'package:TodoApp/bloc/todo_state.dart';
import 'package:TodoApp/repository/todo_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TodoBloc extends Bloc<TodoEvent,TodoState>{
   final TodoRepository todoRepository;
   TodoBloc({@required this.todoRepository}):assert(todoRepository != null),super(TodoLoading());

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async*{
    if(event is TodoLoad){
      yield TodoLoading();
      try{
        final todos = await todoRepository.getTodos();
        yield TodoLoadSuccess(todos);
      }catch(_){
        yield TodoOperationFailure();
      }
    }
    if(event is TodoUpdate){
      try{
        await todoRepository.updateTodo(event.todo);
        final todos = await todoRepository.getTodos();
        yield TodoLoadSuccess(todos);
      }catch(_){
        yield TodoOperationFailure();

      }
    }
    if(event is TodoDelete){
      try{
        await todoRepository.deleteTodo(event.todo.id);
        final todos = await todoRepository.getTodos();
        yield TodoLoadSuccess(todos);
      }catch(_){
        yield TodoOperationFailure();
      }
    }

  }


}