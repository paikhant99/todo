import 'package:flutter/widgets.dart';
import 'package:todo/models.dart';
import 'package:todo/persistence/local_repository.dart';

class TasksViewModel extends ChangeNotifier {
  /*
    Comments - 
  */

  final List<Task> tasks = [];
  var isAddTaskFieldVisible = false;
  final LocalRepository localRepo;

  TasksViewModel({required this.localRepo});

  void addTask(Task? task) {
    isAddTaskFieldVisible = false;
    if (task != null) {
      localRepo.createTask(task).whenComplete(() => loadTasks());
    }
    notifyListeners();
  }

  void toggleTask(int taskId, bool changedTaskState) {
    localRepo
        .updateTaskCompletion(taskId, changedTaskState ? 1 : 0)
        .whenComplete(() => loadTasks());
  }

  void removeTask(int taskId) {
    localRepo.deletTask(taskId).whenComplete(() => loadTasks());
  }

  Future loadTasks() {
    return localRepo.loadTasks().then((loadedTasks) {
      tasks.clear();
      tasks.addAll(loadedTasks);
      notifyListeners();
    }).catchError((err) {
      notifyListeners();
    });
  }

  void setAddTaskFieldVisible(bool fieldVisible) {
    isAddTaskFieldVisible = fieldVisible;
    notifyListeners();
  }
}
