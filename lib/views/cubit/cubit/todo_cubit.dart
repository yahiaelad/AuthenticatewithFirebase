import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/todos.dart';
import '../../../services/todos_services.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial()) {
    gettodosfromapi();
  }

  List<Todosmodel> todos = [];
  bool isloading = true;

  gettodosfromapi() async {
    try {
      emit(Todoloading());
      todos = await todos_services().get_todos();
      emit(Todosucess());
    } catch (e) {
      print(e.toString());
      emit(Todoerror());
    }
  }
}
