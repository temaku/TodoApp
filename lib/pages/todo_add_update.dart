import '../todo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddUpdateTodo extends StatefulWidget {
  static const routeName = 'todoAddUpdate';
   final TodoArguments args;
   AddUpdateTodo({this.args});
  @override
  _AddUpdateTodoState createState() => _AddUpdateTodoState();
}

class _AddUpdateTodoState extends State<AddUpdateTodo> {
   final _formKey = GlobalKey<FormState>();
   final  Map<String,dynamic>_todo ={};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.args.edit?"Edit Todo":"Add New Todo"}'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: widget.args.edit?widget.args.todo.title:'',
                validator: (value){
                  if(value.isEmpty){
                    return 'Please enter todo title';
                  }
                  return null;
                },
                decoration: InputDecoration(labelText: "Todo title"),
                onSaved: (value){
                  setState(() {
                    this._todo["title"] = value;
                  });
                }),
              TextFormField(
                  initialValue:
                  widget.args.edit ? widget.args.todo.description : '',
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter todo description';
                    }
                    return null;
                  },
                  decoration: InputDecoration(labelText: 'Description'),
                  onSaved: (value) {
                    setState(() {
                      this._todo["description"] = value;
                    });
                  }),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: ElevatedButton.icon(
                    onPressed: (){
                      final form = _formKey.currentState;
                      if(form.validate()){
                        form.save();
                        final TodoEvent event = widget.args.edit?TodoUpdate(
                          Todo(
                            id: widget.args.todo.id,
                            title:this._todo["title"],
                            description:this._todo["description"],
                            dateCreated: this._todo["dateCreated"]
                          )
                        ):
                            TodoCreate(
                              Todo(
                                title:this._todo["title"],
                                description:this._todo["description"],
                                dateCreated: this._todo["dateCreated"]
                              )
                            );
                        BlocProvider.of<TodoBloc>(context).add(event);
                        Navigator.of(context).pushNamedAndRemoveUntil(
                         TodoList.routeName,(route) => false);
                      }
                    },
                    icon: Icon(Icons.save),
                    label:Text("SAVE")),
              )


            ],
          ),
        ),
      ),
    );
  }
}
