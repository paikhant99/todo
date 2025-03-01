import 'package:get/get.dart';
import 'package:todo/data/entity/task.dart';
import 'package:todo/data/repository/task_repository.dart';

class TasksController extends GetxController {
  final tasks = <Task>[].obs;
  final isMultipleSelected = false.obs;
  final selectedTasks = <Task>[].obs;

  final TaskRepository repo;

  TasksController({required this.repo});

  // (Fetch Tasks) : Fetch all uncompleted tasks;
  void fetchTasks({int goalId = 1}) {
    repo.loadAllTasksByGoal(goalId).then((taskValues) {
      tasks.assignAll(taskValues);
    });
  }

  // (Add Task) : Add a new pop up task and fetch tasks after all.
  void addTask(String taskName, String description) {
    final taskCreate = Task(
      taskName: taskName,
      description: description,
    );
    repo.createTask(taskCreate);
    fetchTasks();
  }

  // (Update Task Check) : Update Task Completion as completed or in_progress
  void updateTaskCheck(int taskId, bool checked) {
    repo.markTaskCheck(taskId, checked);
    fetchTasks();
  }

  // (Do Multiple Selection) : Select multiple tasks for batch operations
  void doMultipleSelection(Task task) {
    if (isMultipleSelected.isTrue) {
      if (selectedTasks.contains(task)) {
        selectedTasks.remove(task);
      } else {
        selectedTasks.add(task);
      }

      if (selectedTasks.isEmpty) {
        isMultipleSelected.value = false;
      }
    }
  }

  // (Clear Multiple Selection) : Clear all selected tasks
  void clearMultipleSelection() {
    selectedTasks.clear();
    isMultipleSelected.value = false;
  }

  // (Archive Tasks) : Archive tasks by setting archived_at attribute with current timestamp
  void archiveTasks() {
    final ids = selectedTasks.map((task) => task.taskId!).toList();
    repo.archiveTasks(ids).then((value) {
      fetchTasks();
      clearMultipleSelection();
    });
    
  }
}
