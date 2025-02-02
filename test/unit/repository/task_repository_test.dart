import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/data/entity/task.dart';
import 'package:todo/data/repository/task_repository.dart';
import 'package:todo/data/persistence/task_dao.dart';

import 'task_repository_test.mocks.dart';

@GenerateMocks([TaskDao])
void main() {
  /*
    Comments -
    Mock TaskDao
  */

  late MockTaskDao mockTaskDao;
  late TaskRepository taskRepository;

  // (Set Up) : Initialize mockTaskDao and taskRepository
  setUp(() {
    mockTaskDao = MockTaskDao();
    taskRepository = TaskRepository(taskDao: mockTaskDao);
  });

  // (Test - Add New Pop up Task) : Test createTask method of taskRepository
  test('Add New Pop up Task', () async {
    var task = Task(
        taskId: 1,
        taskName: 'Finish Flutter Project',
        description: 'Complete two steps first');

    when(mockTaskDao.create(task)).thenAnswer((_) async => task.taskId!);

    var taskReturnId = await taskRepository.createTask(task);

    expect(taskReturnId, task.taskId);
  });

  // (Test - Display Backlog Tasks) : Test loadAllTasks method of taskRepository
  test('Display Backlog Tasks', () async {
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

    when(mockTaskDao.readAllTasks()).thenAnswer((_) async => tasks);

    var tasksReturn = await taskRepository.loadAllTasks();

    expect(tasksReturn.length, tasks.length);
  });

  group('Mark Task as Completed or InProgress', () {
    // (Test - Mark Task as Completed) : Test markTaskCheck method of taskRepository setting checked : true
    test('Mark Task as Completed', () async {
      var task = Task(
          taskId: 1,
          taskName: 'Finish Flutter Project',
          description: 'Complete two steps first');

      when(mockTaskDao.markCompleted(task.taskId)).thenAnswer((_) async => 1);

      var noOfTasksChangedReturn =
          await taskRepository.markTaskCheck(task.taskId!, true);

      expect(noOfTasksChangedReturn, 1);
    });

    // (Test - Mark Task as In Progress) : Test markTaskCheck method of taskRepository setting checked : false
    test('Mark Task as In Progress', () async {
      var task = Task(
          taskId: 1,
          taskName: 'Finish Flutter Project',
          description: 'Complete two steps first');

      when(mockTaskDao.markInProgress(task.taskId)).thenAnswer((_) async => 1);

      var noOfTasksChangedReturn =
          await taskRepository.markTaskCheck(task.taskId!, false);

      expect(noOfTasksChangedReturn, 1);
    });
  });
}
