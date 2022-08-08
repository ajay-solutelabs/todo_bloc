part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable{
  const TaskEvent();

  @override
  List<Object?> get props => [];
}

class GetAllTask extends TaskEvent {
  const GetAllTask();

  @override
  List<Object?> get props => [];
}

class AddTask extends TaskEvent {
  final Task task;

  const AddTask({required this.task});

  @override
  List<Object?> get props => [task];
}

class UpdateTask extends TaskEvent {
  final Task task;
  final bool isCompleted;

  const UpdateTask({required this.task, required this.isCompleted});

  @override
  List<Object?> get props => [task];
}

class UpdateTaskRecycleBin extends TaskEvent {
  final Task task;

  const UpdateTaskRecycleBin({required this.task});

  @override
  List<Object?> get props => [task];
}

class RemoveTask extends TaskEvent {
  final Task task;

  const RemoveTask({required this.task});

  @override
  List<Object?> get props => [task];
}

class DeleteTask extends TaskEvent {
  final Task task;

  const DeleteTask({required this.task});

  @override
  List<Object?> get props => [task];
}
