part of 'tasks_bloc.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

class EmptyState extends TasksState {}

class LoadingState extends TasksState {}

class LaodedState extends TasksState {
  final List<Task> tasks;
  const LaodedState(this.tasks);
}

class LoadNotifyState extends TasksState {}
