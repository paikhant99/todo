import 'package:todo/app_constants.dart';

// DB_Service
var dbName = "${APP_TITLE.toLowerCase()}_database.db";
var dbVersion = 1;
var queriesV_1 = [
  "CREATE TABLE $goalsTableName ($goalId INTEGER PRIMARY KEY AUTOINCREMENT, $goalName TEXT NOT NULL, $createdAt TEXT NOT NULL, $modifiedAt TEXT NOT NULL)",
  "INSERT INTO $goalsTableName ($goalName, $createdAt, $modifiedAt) VALUES ('backlog', datetime('now'), datetime('now'))",
  "CREATE TABLE $tasksTableName ($taskId INTEGER PRIMARY KEY AUTOINCREMENT, $taskName TEXT NOT NULL, $taskDesc TEXT, $taskCompletedAt TEXT DEFAULT NULL, $taskArchivedAt TEXT DEFAULT NULL, $createdAt TEXT NOT NULL, $modifiedAt TEXT NOT NULL, $taskGoalId INTEGER DEFAULT 1, FOREIGN KEY ($goalId) REFERENCES $goalsTableName($goalId) ON DELETE CASCADE)",
];
var createdAt = 'created_at';
var modifiedAt = 'modified_at';

// Task Dao
var tasksTableName = 'tasks';
var taskId = 'id';
var taskName = 'name';
var taskDesc = 'description';
var taskCompletedAt = 'completed_at';
var taskArchivedAt = 'archived_at';
var taskGoalId = 'goal_id';

// Goal Dao
var goalsTableName = 'goals';
var goalId = 'id';
var goalName = 'name';