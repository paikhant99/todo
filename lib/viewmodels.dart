import 'package:flutter/widgets.dart';
import 'package:todo/models.dart';
import 'package:todo/persistence/local_repository.dart';

class UncompletedTasksHomePageViewModel extends ChangeNotifier {
  /*
    Comments - 
  */

  final List<Task> uncompletedTasks = [];
  final LocalRepository localRepo;

  UncompletedTasksHomePageViewModel({required this.localRepo});

  void addTask(Task? task, String date) {
    if (task != null) {
      localRepo.createTask(task).whenComplete(() => loadTasks(date));
    }
    notifyListeners();
  }

  void toggleTask(int taskId, bool changedTaskState, String date) {
    localRepo
        .updateTaskCompletion(taskId, changedTaskState ? 1 : 0)
        .whenComplete(() => loadTasks(date));
  }

  void removeTask(int taskId, String date) {
    localRepo.deleteTask(taskId).whenComplete(() => loadTasks(date));
  }

  Future loadTasks(String date) {
    return localRepo.loadUnCompletedTasksByDate(date).then((loadedTasks) {
      uncompletedTasks.clear();
      uncompletedTasks.addAll(loadedTasks);
      notifyListeners();
    }).catchError((err) {
      notifyListeners();
    });
  }
}

class CompletedAllTasksScreenViewModel extends ChangeNotifier {
  final List<Task> completedTasks = [];
  final LocalRepository localRepo;

  CompletedAllTasksScreenViewModel({required this.localRepo});

  Future loadTasks(String date) {
    return localRepo.loadCompletedTasksByDate(date).then((loadedTasks) {
      completedTasks.clear();
      completedTasks.addAll(loadedTasks);
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

class AllTasksScreenViewModel extends ChangeNotifier {
  final List<Task> allTasks = [];
  final LocalRepository localRepo;

  AllTasksScreenViewModel({required this.localRepo});

  Future loadTasks(String date) {
    return localRepo.loadAllTasksByDate(date).then((loadedTasks) {
      allTasks.clear();
      allTasks.addAll(loadedTasks);
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
