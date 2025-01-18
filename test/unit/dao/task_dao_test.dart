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

    var tasksReturn = await taskDao.readAllTasks();

    expect(tasksReturn.length, tasks.length);
  });
}
