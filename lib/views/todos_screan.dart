import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit/todo_cubit.dart';

class todosscrean extends StatefulWidget {
  const todosscrean({super.key});

  @override
  State<todosscrean> createState() => _todosscreanState();
}

class _todosscreanState extends State<todosscrean> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: Text("Todos"),
          centerTitle: true,
        ),
        body: BlocProvider(
          create: (context) => TodoCubit(),
          child: BlocConsumer<TodoCubit, TodoState>(
            listener: (context, state) {
              // TODO: implement listener
            },
            builder: (context, state) {
              return state is Todoloading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : state is Todosucess
                      ? ListView.builder(
                          itemCount: context.watch<TodoCubit>().todos.length,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              title: Text(context
                                      .watch<TodoCubit>()
                                      .todos[index]
                                      .title ??
                                  "no data"),
                            );
                          },
                        )
                      : Center(child: Text("error"));
            },
          ),
        ));
  }
}
