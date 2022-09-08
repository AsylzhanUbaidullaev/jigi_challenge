part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object?> get props => [];
}

class LoadEvent extends TasksEvent {}

class AddTaskEvent extends TasksEvent {
  final int id;
  final String title;
  final bool isDone;
  const AddTaskEvent({
    required this.id,
    required this.title,
    required this.isDone,
  });

  @override
  List<Object> get props => [title, isDone];
}

class SetTaskStatusEvent extends TasksEvent {
  final int id;
  final bool isDone;
  final int index;

  const SetTaskStatusEvent(this.id, this.isDone, this.index);

  @override
  List<Object?> get props => [id, isDone];
}
