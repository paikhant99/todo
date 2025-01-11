import 'package:get/get.dart';
import 'package:todo/persistence/task.dart';

class TasksController extends GetxController{
  final tasks = <Task>[].obs;
  final updatedTasks = [
      Task(taskId: 1, taskName: "Design Architecture", goalName: "Design-UI", taskTime: DateTime.now().toString(), isCompleted: false, description: ''),
      Task(taskId: 2, taskName: "Design Prototype", goalName: "Design-UI", taskTime: DateTime.now().toString(), isCompleted: false, description: '')
      ];

  @override
  void onInit() {
    super.onInit();
    tasks.assignAll(updatedTasks);
  }

  void addTask(String taskName, String description){
    final taskCreate = Task(
      taskId: 3,
      taskName: taskName,
      goalName: 'Backlog',
      description: description,
      taskTime: null
      );
    tasks.add(taskCreate);
    tasks.refresh();
  }

  void updateTaskCheck(Task task){
    tasks.removeWhere((t) => t.taskId == task.taskId);
    tasks.add(task);
  }


}