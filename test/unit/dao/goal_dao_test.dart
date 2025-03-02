import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/data/data_constants.dart';
import 'package:todo/data/persistence/db_service.dart';
import 'package:todo/data/persistence/goal_dao.dart';

import '../../integration/display_goals_test.mocks.dart';

@GenerateMocks([SQLiteDatabaseService, Database])
void main() {
  /*
    Comments -
    Mock SQLiteDatabaseService
    Mock Database
  */

  late MockSQLiteDatabaseService mockDbService;
  late MockDatabase mockDb;
  late GoalDao goalDao;

  // (Set Up) : Initialize mockDbService, mockDb, and taskDao
  setUp(() {
    mockDbService = MockSQLiteDatabaseService();
    mockDb = MockDatabase();
    goalDao = GoalDao(databaseService: mockDbService);
    when(mockDbService.getDatabase()).thenAnswer((_) async => mockDb);
  });

  test('Display Goals ', () async {
    var goals = [
      {
        goalId: 1,
        goalName: 'Finish Flutter Project 1',
      },
      {
        goalId: 2,
        goalName: 'Finish Flutter Project 2',
      }
    ];

    when(mockDb.rawQuery('SELECT * FROM $goalsTableName WHERE $goalId NOT IN (SELECT $goalId FROM $goalsTableName ORDER BY $goalId ASC LIMIT 1)')).thenAnswer((_) async => goals);

    when(mockDb.rawQuery(
        'SELECT COUNT(*) as count FROM $tasksTableName WHERE $taskGoalId = ? AND $taskCompletedAt IS NOT NULL AND $taskArchivedAt IS NULL',
        argThat(isInstanceOf<List<Object?>>()),
      )).thenAnswer((_) async => [{'count': 1}]);

    when(mockDb.rawQuery(
        'SELECT COUNT(*) as count FROM $tasksTableName WHERE $taskGoalId = ? AND $taskArchivedAt IS NULL',
        argThat(isInstanceOf<List<Object?>>()),
      )).thenAnswer((_) async => [{'count': 1}]);

    var goalsReturn = await goalDao.readAllGoals();

    expect(goalsReturn.length, goals.length);
  });
}