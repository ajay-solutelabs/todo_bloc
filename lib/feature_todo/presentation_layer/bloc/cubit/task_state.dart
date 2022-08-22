part of 'task_cubit.dart';

@immutable
abstract class TaskState extends Equatable{}

class TaskInitial extends TaskState {
  TaskInitial();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TaskLoading extends TaskState {
  TaskLoading();

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class TaskLoaded extends TaskState {
  TaskLoaded(this.allTasks);
  final List<Task?>? allTasks;

  @override
  // TODO: implement props
  List<Object?> get props => [allTasks];
}

class TaskError extends TaskState {
  TaskError(this.message);
  final String? message;

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

