part of 'todo_cubit.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}

class Todoloading extends TodoState {}

class Todosucess extends TodoState {}

class Todoerror extends TodoState {}
