import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/data/data_constants.dart';
import 'package:todo/data/entity/task.dart';
import 'package:todo/data/persistence/db_service.dart';
import 'package:todo/data/persistence/task_dao.dart';

import 'task_dao_test.mocks.dart';

@GenerateMocks([SQLiteDatabaseService, Database])
void main() {
  /*
    Comments -
    Mock SQLiteDatabaseService
    Mock Database
  */

  late MockSQLiteDatabaseService mockDbService;
  late MockDatabase mockDb;
  late TaskDao taskDao;

  // (Set Up) : Initialize mockDbService, mockDb, and taskDao
  setUp(() {
    mockDbService = MockSQLiteDatabaseService();
    mockDb = MockDatabase();
    taskDao = TaskDao(databaseService: mockDbService);
    when(mockDbService.getDatabase()).thenAnswer((_) async => mockDb);
  });

  // (Test - Add New Pop up Task) : Test create method of TaskDao
  test('Add New Pop up Task', () async {
    var task = Task(
        taskId: 1,
        taskName: 'Finish Flutter Project',
        description: 'Complete two steps first');

    when(mockDbService.getCurrentTimestamp()).thenReturn("2025-01-11 12:10:00");

    when(mockDb.insert(
      tasksTableName,
      any,
      nullColumnHack: null,
      conflictAlgorithm: null,
    )).thenAnswer((_) async => task.taskId!);

    var taskReturnId = await taskDao.create(task);

    expect(taskReturnId, task.taskId);
  });

  // (Test - Display Backlog Taks) : Test readAllTasks method of TaskDao
  test('Display Backlog Tasks', () async {
    var tasks = [
      {
        taskId: 1,
        taskName: 'Finish Flutter Project 1',
        taskDesc: 'Complete two steps first'
      },
      {
        taskId: 1,
        taskName: 'Finish Flutter Project 2',
        taskDesc: 'Complete three steps first'
      }
    ];

    when(mockDb.query(tasksTableName)).thenAnswer((_) async => tasks);

    var tasksReturn = await taskDao.readAllUnarchivedTasksByGoal(1);

    expect(tasksReturn.length, tasks.length);
  });

  group('Mark Task Completed or InProgress', () {
    // (Test - Mark Task as Completed) : Test markCompleted method of TaskDao
    test('Mark Task as Completed', () async {
      var task = Task(
          taskId: 1,
          taskName: 'Finish Flutter Project',
          description: 'Complete two steps first');
      when(mockDbService.getCurrentTimestamp())
          .thenReturn("2025-01-11 12:10:00");

      when(mockDb.update(tasksTableName, any,
          where: '$taskId = ?',
          whereArgs: [task.taskId])).thenAnswer((_) async => 1);

      var noOfTasksChangedReturn = await taskDao.markCompleted(task.taskId!);

      expect(noOfTasksChangedReturn, 1);
    });

    // (Test - Mark Task as InProgress) : Test markInProgress method of TaskDao
    test('Mark Task as InProgress', () async {
      var task = Task(
          taskId: 1,
          taskName: 'Finish Flutter Project',
          description: 'Complete two steps first');

      when(mockDb.update(tasksTableName, {taskCompletedAt: null},
          where: '$taskId = ?',
          whereArgs: [task.taskId])).thenAnswer((_) async => 1);

      var noOfTasksChangedReturn = await taskDao.markInProgress(task.taskId!);

      expect(noOfTasksChangedReturn, 1);
    });

    // (Test - Archive Tasks) : Test archiveTasks method of TaskDao
    test('Archive Tasks', () async {
      var taskIds = [1, 2, 3];
      var task = Task(
          taskId: 1,
          taskName: 'Finish Flutter Project',
          description: 'Complete two steps first');

      when(mockDbService.getCurrentTimestamp())
          .thenReturn("2025-01-11 12:10:00");

      when(mockDb.update(
        any,
        any,
        where: anyNamed('where'),
        whereArgs: anyNamed('whereArgs'),
        conflictAlgorithm: anyNamed('conflictAlgorithm'),
      )).thenAnswer((_) async => 1);

      var noOfTasksChangedReturn = await taskDao.archiveTasks(taskIds);

      expect(noOfTasksChangedReturn.length, taskIds.length);
    });
  });
}
