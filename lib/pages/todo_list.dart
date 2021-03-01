import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../todo.dart';

class TodoList extends StatelessWidget {
  static const String routeName = '/';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List of Todo'),
      ),
      body: BlocBuilder<TodoBloc,TodoState>(
          builder: (_,state) {
            if (state is TodoOperationFailure) {
              return Text('Could not do todo operation');
            }
            if (state is TodoLoadSuccess) {
              final todos = state.todos;
              return ListView.builder(
                  itemCount: todos.length,
                  itemBuilder: (_, idx) =>
                      ListTile(
                        title: Text('${todos[idx].title}'),
                        subtitle: Text('${todos[idx].description}'),
                        onTap: () =>
                            Navigator.of(context).pushNamed(
                              TodoDetail.routeName, arguments: todos[idx],
                            ),

                      )
              );
            }
            return CircularProgressIndicator();
          }
          ),
           floatingActionButton: FloatingActionButton(
             onPressed: ()=>Navigator.of(context).pushNamed(
               AddUpdateTodo.routeName,arguments: TodoArguments(edit:false),
             ),
             child: Icon(Icons.add),
           ),
    );
          }

  }

