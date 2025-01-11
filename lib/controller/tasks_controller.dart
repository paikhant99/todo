import 'package:get/get.dart';
import 'package:todo/data/entity/task.dart';
import 'package:todo/data/local_repository.dart';

class TasksController extends GetxController {
  final tasks = <Task>[].obs;
  final updatedTasks = [
    Task(
        taskId: 1,
        taskName: "Design Architecture",
        isCompleted: false,
        description: ''),
    Task(
        taskId: 2,
        taskName: "Design Prototype",
        isCompleted: false,
        description: '')
  ];

  final LocalRepository repo;

  TasksController({required this.repo});

  // (On Init - Event) : Initialize all states in controller.
  @override
  void onInit() {
    super.onInit();
    fetchTasks();
  }

  // (Fetch Tasks) : Fetch all uncompleted tasks;
  void fetchTasks(){
    tasks.assignAll(updatedTasks);
  }

  // (Add Task) : Add a new pop up task and fetch tasks after all.
  void addTask(String taskName, String description) {
    final taskCreate = Task(
      taskId: 3,
      taskName: taskName,
      description: description,
    );
    repo.createTask(taskCreate);
    fetchTasks();
  }

  // void updateTaskCheck(Task task) {
  //   tasks.removeWhere((t) => t.taskId == task.taskId);
  //   tasks.add(task);
  // }
}
