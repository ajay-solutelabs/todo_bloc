// ignore_for_file: must_be_immutable

part of 'task_bloc.dart';

class TaskState extends Equatable {
  List<Task?> allTasks;
  List<Task?> removedTask;
  List<Task?> completedTask;
  TaskState({this.allTasks = const <Task>[], this.removedTask = const <Task>[], this.completedTask = const <Task>[]});

  @override
  List<Object?> get props => [allTasks, removedTask, completedTask];

  Map<String, dynamic> toMap() {
    return {
      'allTasks': allTasks.map((e) => e?.toMap()).toList(),
      'removedTask': removedTask.map((e) => e?.toMap()).toList(),
      'completedTask': completedTask.map((e) => e?.toMap()).toList(),
    };
  }

  factory TaskState.fromMap(Map<String, dynamic> map) {
    return TaskState(
      allTasks: List<Task>.from(map['allTasks']?.map((x) => Task.fromMap(x),),),
      removedTask: List<Task>.from(map['removedTask']?.map((x) => Task.fromMap(x),),),
      completedTask: List<Task>.from(map['completedTask']?.map((x) => Task.fromMap(x),),),
    );
  }
}

class TaskLoadingState extends TaskState {}

