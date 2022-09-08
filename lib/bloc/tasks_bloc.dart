import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_thoughts/model/task.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final Repo repo;

  TasksBloc({required this.repo}) : super(LoadingState()) {
    on<LoadEvent>((event, emit) {
      emit(LaodedState(repo.tasks));
    });

    on<AddTaskEvent>((event, emit) {
      emit(LoadingState());
      repo.tasks;
      repo.addTask(
          Task(id: event.id, title: event.title, isDone: event.isDone));
      emit(LoadNotifyState());
      emit(LaodedState(repo.tasks));
    });

    on<SetTaskStatusEvent>((event, emit) {
      emit(LoadingState());
      repo.setStatus(event.id, event.isDone, event.index);
      emit(LaodedState(repo.tasks));
    });
  }
}

class Repo {
  List<Task> tasks = [];

  addTask(Task task) {
    tasks.insert(0, task);
  }

  setStatus(int id, bool value, int index) {
    for (int i = 0; i < tasks.length; i++) {
      log('Id: ${tasks[index].id}');
      log("ID: $id");
      if (tasks[i].id == id) {
        tasks[i].isDone = value;
        if (value) {
          tasks.add(tasks[i]);
          tasks.removeAt(index);
          return;
        } 
      }
    }
  }
}
