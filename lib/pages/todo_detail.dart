import '../todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class TodoDetail extends StatelessWidget{
  static const routeName = 'courseDetail';
  final Todo todo;
  TodoDetail({@required this.todo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${this.todo.title}'
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.edit),
              onPressed: ()=>Navigator.of(context).pushNamed(
                AddUpdateTodo.routeName,
                arguments: TodoArguments(todo:this.todo,edit:true),
              )
          ),
          SizedBox(
            width: 32,
          ),
          IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                context.read<TodoBloc>().add(TodoDelete(this.todo));
                Navigator.of(context).pushNamedAndRemoveUntil(
                    TodoList.routeName, (route) => false);
              }),
        ],
      ),
      body: Card(
        child: Column(
          children: [
            ListTile(
              title: Text('Title:${this.todo.title}'),
              subtitle: Text("description:${this.todo.description}"),
            ),
            Text(
              "Details",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),

            ),
            SizedBox(
              height: 10,
            ),
            Text(this.todo.description),
          ],
        ),
      ),

    );


  }
}