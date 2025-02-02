import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/controller/tasks_controller.dart';
import 'package:todo/data/entity/task.dart';
import 'package:todo/data/repository/task_repository.dart';

import 'tasks_controller_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  /*
    Comments -
    Mock TaskRepository
  */

  late MockTaskRepository mockTaskRepository;
  late TasksController taskController;

  // (Set Up) : Initialize mockTaskRepository and taskController
  setUp(() {
    mockTaskRepository = MockTaskRepository();
    taskController = TasksController(repo: mockTaskRepository);
  });

  // (Test - Add New Pop up Task) : Test addTask method of TasksController
  test('Add New Pop up Task', () {
    var task = Task(
        taskName: 'Finish Flutter Project',
        description: 'Complete two steps first');

    when(mockTaskRepository.createTask(any)).thenAnswer((_) async => 1);

    taskController.addTask(task.taskName, task.description);

    verify(mockTaskRepository.createTask(any));
  });

  // (Test - Display Backlog Tasks) : Test fetchTasks method of TasksController
  test('Display Backlog Tasks', () {
    var tasks = [
      Task(
          taskId: 1,
          taskName: 'Finish Flutter Project 1',
          description: 'Complete two steps first'),
      Task(
          taskId: 2,
          taskName: 'Finish Flutter Project 2',
          description: 'Complete three steps first')
    ];

    when(mockTaskRepository.loadAllTasks()).thenAnswer((_) async => tasks);

    taskController.fetchTasks();

    verify(mockTaskRepository.loadAllTasks());
  });

  group('Mark Task as Completed or InProgress', () {
    // (Test - Mark Task as Completed) : Test updateTaskCheck method of TasksController
    test('Mark Task as Completed', () {
      var task = Task(
          taskId: 1,
          taskName: 'Finish Flutter Project',
          description: 'Complete two steps first');

      var tasks = [
        Task(
            taskId: 1,
            taskName: 'Finish Flutter Project 1',
            description: 'Complete two steps first'),
        Task(
            taskId: 2,
            taskName: 'Finish Flutter Project 2',
            description: 'Complete three steps first')
      ];

      when(mockTaskRepository.loadAllTasks()).thenAnswer((_) async => tasks);

      when(mockTaskRepository.markTaskCheck(task.taskId, true))
          .thenAnswer((_) async => 1);

      taskController.updateTaskCheck(task.taskId!, true);

      verify(mockTaskRepository.markTaskCheck(task.taskId!, true));
    });

    // (Test - Mark Task as In Progress) : Test updateTaskCheck method of TasksController
    test('Mark Task as In Progress', () {
      var task = Task(
          taskId: 1,
          taskName: 'Finish Flutter Project',
          description: 'Complete two steps first');

      var tasks = [
        Task(
            taskId: 1,
            taskName: 'Finish Flutter Project 1',
            description: 'Complete two steps first'),
        Task(
            taskId: 2,
            taskName: 'Finish Flutter Project 2',
            description: 'Complete three steps first')
      ];

      when(mockTaskRepository.loadAllTasks()).thenAnswer((_) async => tasks);

      when(mockTaskRepository.markTaskCheck(task.taskId, false))
          .thenAnswer((_) async => 1);

      taskController.updateTaskCheck(task.taskId!, false);

      verify(mockTaskRepository.markTaskCheck(task.taskId!, false));
    });
  });
}
