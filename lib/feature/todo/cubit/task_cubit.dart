import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/feature/todo/models/task/task.dart';
import 'package:todo_app/feature/todo/repository/api_repository.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  final ApiRepository _apiRepository;
  TaskCubit(this._apiRepository) : super(TaskInitial());
  List<Task?> allTasks = [];

  Future<void> getAllTask() async {
    try {
      emit(TaskLoading());
      if(allTasks.isNotEmpty){
        allTasks.clear();
      }
      final mList = await _apiRepository.fetchTaskList();
      allTasks = List.from(allTasks)..addAll(mList);
      emit(TaskLoaded(allTasks));
    } catch(e) {
      debugPrint("$e");
    }
  }

  void addTask(Task task) async {
    try {
      emit(TaskLoading());
      await _apiRepository.addTask(task.title, task.description);
      getAllTask();
      emit(TaskLoaded(allTasks));
    } catch(e) {
      debugPrint("$e");
    }
  }

  void updateTask(Task task, bool isCompleted) async {

    List<Task> allTask = List.from(allTasks);

    emit(TaskLoading());

      final int index = allTask.indexOf(task);

      allTask.removeAt(index);
      await _apiRepository.updateTaskisDone(task.id, true);

    emit(TaskLoaded(allTask));
  }

  void removeTask(Task task) {
    final int index = allTasks.indexOf(task);

    List<Task> allTask = List.from(allTasks)..removeAt(index);

    emit(TaskLoaded(allTask));
  }
}
