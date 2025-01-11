import 'dart:collection';

import 'package:flutter/widgets.dart';
import 'package:todo/persistence/task.dart';
import 'package:todo/persistence/local_repository.dart';

class AllTasksViewModel extends ChangeNotifier {
  final List<Task> _allTasks = [];

  UnmodifiableListView<Task> get updatedAllTasks =>
      UnmodifiableListView(_allTasks.reversed.toList());
  UnmodifiableListView<Task> get updatedUncompletedTasks =>
      UnmodifiableListView(
          _allTasks.reversed.where((task) => task.isCompleted == 0).toList());
  UnmodifiableListView<Task> get updatedCompletedTasks => UnmodifiableListView(
      _allTasks.reversed.where((task) => task.isCompleted == 1).toList());

  final LocalRepository localRepo;

  AllTasksViewModel({required this.localRepo});

  void addTask(Task? task, String date) {
    if (task != null) {
      localRepo.createTask(task).whenComplete(() => loadTasks(date));
    }
    notifyListeners();
  }

  Future loadTasks(String date) {
    return localRepo.loadAllTasksByDate(date).then((loadedTasks) {
      _allTasks.clear();
      _allTasks.addAll(loadedTasks);
      notifyListeners();
    }).catchError((err) {
      notifyListeners();
    });
  }

  void toggleTask(int taskId, bool changedTaskState, String date) {
    localRepo
        .updateTaskCompletion(taskId, changedTaskState ? 1 : 0)
        .whenComplete(() => loadTasks(date));
  }

  void removeTask(int taskId, String date) {
    localRepo.deleteTask(taskId).whenComplete(() => loadTasks(date));
  }
}
