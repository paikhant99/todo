import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/models.dart';

/*
  Reminder - This service only available in macOs, android, IOS
*/

class LocalRepository {
  /*
    Comments -
  */

  TaskDao taskDao;

  LocalRepository({required this.taskDao});

  Future<List<Task>> loadAllTasksByDate(String date) {
    return taskDao.loadByDate(date);
  }

  Future<List<Task>> loadUnCompletedTasksByDate(String date) {
    return taskDao.loadByDateAndStatus(date, 0);
  }

  Future<List<Task>> loadCompletedTasksByDate(String date) {
    return taskDao.loadByDateAndStatus(date, 1);
  }

  Future<int> createTask(Task task) {
    return taskDao.create(task);
  }

  Future<int> updateTaskCompletion(int taskId, int isCompleted) {
    return taskDao.updateCompleted(taskId, isCompleted);
  }

  Future<int> deleteTask(int taskId) {
    return taskDao.delete(taskId);
  }
}

class TaskDao {
  /*
    Comments - 
  */

  SQLiteDatabaseService databaseService;
  static const String tasksTableName = "tasks";
  static const String updateTaskCompleted =
      "UPDATE $tasksTableName SET completed = ? WHERE id = ?";

  TaskDao({required this.databaseService});

  /*
    Retrieve All Tasks By Specified 'date' from 'tasks' Table
  */
  Future<List<Task>> loadByDate(String date) async {
    var db = await databaseService.getDatabase();
    var tasks = await db
        .query(tasksTableName, where: 'reminder_date = ?', whereArgs: [date]);
    return tasks.map((task) => Task.fromJson(task)).toList();
  }

  /*
    Retrieve Tasks By Specified 'date' and 'status' from 'tasks' Table
  */
  Future<List<Task>> loadByDateAndStatus(String date, int status) async {
    var db = await databaseService.getDatabase();
    var tasks = await db.query(tasksTableName,
        where: 'reminder_date = ? AND completed = ?',
        whereArgs: [date, status]);
    return tasks.map((task) => Task.fromJson(task)).toList();
  }

  /*
    Insert a new task to 'tasks' Table
  */
  Future<int> create(Task task) async {
    var db = await databaseService.getDatabase();
    return await db.insert(tasksTableName, task.toJson());
  }

  /*
    Update completed value of specific 'id' in 'tasks' Table
  */
  Future<int> updateCompleted(int id, int isCompleted) async{
    var db = await databaseService.getDatabase();
    return db.rawUpdate(updateTaskCompleted, [isCompleted, id]);
  }

  /*
    Delete a specific task
  */
  Future<int> delete(int id) async{
    var db = await databaseService.getDatabase();
    return db.delete(tasksTableName, where: "id = ?", whereArgs: [id]);
  }
}

class SQLiteDatabaseService {
  /* 
    Comments - 
    FIXME : Change reminder_date type to INT as milliseconds
  */

  static const String dbName = "todos_database.db";
  static const String createTableQueryV_0DELTA =
      "CREATE TABLE ${TaskDao.tasksTableName} (id INTEGER PRIMARY KEY, task_desc VARCHAR, reminder_date TEXT, reminder_time TEXT, completed INTEGER(2))";
  Database? _db;
  
  // Factory constructor that returns the singleton instance
  Future<Database> getDatabase() async{
    if (_db == null){
      await open();
    }
    return _db!;
  }
  
  /*
    Open a new database connection;
    If db does not exist, create a new db
    Else connect it.
  */
  Future open() async {
    _db = await openDatabase(join(await getDatabasesPath(), dbName),
        onCreate: (db, version) {
      return db.execute(createTableQueryV_0DELTA);
    }, version: 1);
  }

  /*
    Close database connection
  */
  Future close() async {
    if (_db != null) {
      await _db!.close();
      _db = null;
    }
  }
}
