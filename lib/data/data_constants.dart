import 'package:todo/app_constants.dart';

// DB_Service
var dbName = "${APP_TITLE.toLowerCase()}_database.db";
var dbVersion = 1;
var queriesV_1 = [
  "CREATE TABLE $tasksTableName ($taskId INTEGER PRIMARY KEY AUTOINCREMENT, $taskName TEXT NOT NULL, $taskDesc TEXT, $taskCompletedAt TEXT DEFAULT NULL, $createdAt TEXT NOT NULL, $modifiedAt TEXT NOT NULL)",
];
var createdAt = 'created_at';
var modifiedAt = 'modified_at';

// Task Dao
var tasksTableName = 'tasks';
var taskId = 'id';
var taskName = 'name';
var taskDesc = 'description';
var taskCompletedAt = 'completed_at';

