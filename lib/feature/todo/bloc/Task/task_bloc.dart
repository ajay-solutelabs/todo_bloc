
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/feature/todo/bloc/bloc_exports.dart';
import 'package:todo_app/feature/todo/models/task/task.dart';
import 'package:todo_app/feature/todo/repository/api_repository.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskState()) {
    on<AddTask>(_onAddTask);
    on<UpdateTask>(_onUpdateTask);
    on<DeleteTask>(_onDeleteTask);
    on<RemoveTask>(_onRemoveTask);
    on<GetAllTask>(_fetchAllTask);
    on<UpdateTaskRecycleBin>(_onUpdateTaskRecycleBin);
  }

  final ApiRepository _apiRepository = ApiRepository();

  void _fetchAllTask(GetAllTask event, Emitter emit) async {
    final state = this.state;
    try {
      emit(TaskLoadingState());
      final mList = await _apiRepository.fetchTaskList();
      List<Task> allTask = List.from(state.allTasks)..addAll(mList)..toSet().toList();
      emit(TaskState(allTasks:  mList, removedTask: List.from(state.removedTask),completedTask: List.from(allTask)));
    } catch(e) {
      debugPrint("$e");
    }
  }

  void _onAddTask(AddTask event, Emitter emit) async {
    final state = this.state;
    try {
      emit(TaskLoadingState());
      await _apiRepository.addTask(event.task.title, event.task.description);
      emit(TaskState(allTasks: List.from(state.allTasks)..add(event.task),removedTask: state.removedTask));
    } catch(e) {
      debugPrint("$e");
    }
  }

  void _onUpdateTask(UpdateTask event, Emitter emit) async {
    final state = this.state;
    final task = event.task;
    final isCompleted = event.isCompleted;

    List<Task> allTask = List.from(state.allTasks);
    List<Task> completedTask = List.from(state.completedTask);

    emit(TaskLoadingState());

    if(isCompleted) {
      final int indexC = state.completedTask.indexOf(task);

      completedTask.removeAt(indexC);
      allTask.insert(allTask.length, task.copyWith(isDone: false));
      await _apiRepository.updateTaskisDone(task.id, false);

    } else {
      final int index = state.allTasks.indexOf(task);

      allTask.removeAt(index);
      completedTask.add(task.copyWith(isDone: true));
      await _apiRepository.updateTaskisDone(task.id, true);

    }

    emit(TaskState(allTasks: allTask,removedTask: state.removedTask,completedTask: completedTask));
  }

  void _onUpdateTaskRecycleBin(UpdateTaskRecycleBin event, Emitter emit) {
    final state = this.state;
    final task = event.task;
    final int index = state.removedTask.indexOf(task);

    List<Task> removedTask = List.from(state.removedTask)..removeAt(index);

    task.isDone == false
        ? removedTask.insert(index, task.copyWith(isDone: true))
        : removedTask.insert(index, task.copyWith(isDone: false));

    emit(TaskState(allTasks: state.allTasks,removedTask: removedTask));
  }

  void _onDeleteTask(DeleteTask event, Emitter emit) {
    final state = this.state;
    final task = event.task;
    final int indexR = state.removedTask.indexOf(task);

    emit(TaskLoadingState());
    List<Task> removedTask = List.from(state.removedTask)..removeAt(indexR);
    _apiRepository.deleteTask(event.task.id);
    emit(TaskState(allTasks: state.allTasks,removedTask: removedTask));
  }

  void _onRemoveTask(RemoveTask event, Emitter emit) {
    final state = this.state;
    final task = event.task;
    final int index = state.allTasks.indexOf(task);

    List<Task> allTask = List.from(state.allTasks)..removeAt(index);
    List<Task> removedTaskList = List.from(state.removedTask)..add(task.copyWith(isDeleted: true));

    emit(TaskState(allTasks: allTask,removedTask: removedTaskList));
  }

  @override
  TaskState? fromJson(Map<String, dynamic> json) {
    return TaskState.fromMap(json);
  }

  @override
  Map<String, dynamic>? toJson(TaskState state) {
    return state.toMap();
  }
}

