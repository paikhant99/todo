import 'package:sqflite/sqflite.dart';
import 'package:todo/data/data_constants.dart';
import 'package:todo/data/entity/goal.dart';
import 'package:todo/data/persistence/db_service.dart';

class GoalDao {
  /*
    Comments - 
  */

  late SQLiteDatabaseService databaseService;

  GoalDao({required this.databaseService});

  // (Read All Goals) : Read all goals from 'goals' table.
  Future<List<Goal>> readAllGoals() async {
    var db = await databaseService.getDatabase();
    var goals = await db.rawQuery(
      'SELECT * FROM $goalsTableName WHERE $goalId NOT IN (SELECT $goalId FROM $goalsTableName ORDER BY $goalId ASC LIMIT 1)',
    );
    return Future.wait(goals.map((goal) async {
      var completedTasksCount = await db.rawQuery(
        'SELECT COUNT(*) as count FROM $tasksTableName WHERE $taskGoalId = ? AND $taskCompletedAt IS NOT NULL AND $taskArchivedAt IS NULL',
        [goal[goalId]],
      );
      var allTasksCount = await db.rawQuery(
        'SELECT COUNT(*) as count FROM $tasksTableName WHERE $taskGoalId = ? AND $taskArchivedAt IS NULL',
        [goal[goalId]],
      );
      return Goal(
        goalId: goal[goalId] as int,
        goalName: goal[goalName] as String,
        completedTasksCount: Sqflite.firstIntValue(completedTasksCount) ?? 0,
        allTasksCount: Sqflite.firstIntValue(allTasksCount) ?? 0,
      );
    }).toList());
  }
}
