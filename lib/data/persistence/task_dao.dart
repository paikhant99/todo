import 'package:todo/data/data_constants.dart';
import 'package:todo/data/entity/task.dart';
import 'package:todo/data/persistence/db_service.dart';

class TaskDao {
  /*
    Comments - 
  */

  late SQLiteDatabaseService databaseService;
  // static const String updateTaskCompleted =
  //     "UPDATE $tasksTableName SET completed = ? WHERE id = ?";

  TaskDao({required this.databaseService});

  // (Create) : Insert a new pop up task to 'tasks' table.
  Future<int> create(Task task) async {
    var db = await databaseService.getDatabase();
    return await db.insert(tasksTableName, {
      taskName: task.taskName,
      taskDesc: task.description,
      createdAt: databaseService.getCurrentTimestamp(),
      modifiedAt: databaseService.getCurrentTimestamp()
    });
  }

  // (Read All Unarchived Tasks) : Read all unarchived tasks from 'tasks' table.
  Future<List<Task>> readAllUnarchivedTasks() async {
    var db = await databaseService.getDatabase();
    var tasks = await db.query(tasksTableName, where: '$taskArchivedAt IS NULL');
    return tasks
        .map((task) => Task(
            taskId: task[taskId] as int,
            taskName: task[taskName] as String,
            description: task[taskDesc] as String,
            isCompleted: (task[taskCompletedAt]) != null))
        .toList();
  }

  // (Update Completed At) : Update completed at attribute with current timestamp
  Future<int> markCompleted(int id) async {
    var db = await databaseService.getDatabase();
    return db.update(tasksTableName,
        {taskCompletedAt: databaseService.getCurrentTimestamp()},
        where: '$taskId = ?', whereArgs: [id]);
  }

  // (Update Completed At) : Update completed at attribute with current timestamp
  Future<int> markInProgress(int id) async {
    var db = await databaseService.getDatabase();
    return db.update(tasksTableName,
        {taskCompletedAt: null},
        where: '$taskId = ?', whereArgs: [id]);
  }

  // (Archive Tasks) : Archive tasks by setting archived_at attribute with current timestamp
  Future<List<int>> archiveTasks(List<int> ids) async {
    var db = await databaseService.getDatabase();
    return Future.wait(ids.map((id) async {
      return db.update(tasksTableName,
          {taskArchivedAt: databaseService.getCurrentTimestamp()},
          where: '$taskId = ?', whereArgs: [id]);
    }));
  }

  // /*
  //   Retrieve All Tasks By Specified 'date' from 'tasks' Table
  // */
  // Future<List<Task>> loadByDate(String date) async {
  //   var db = await databaseService.getDatabase();
  //   var tasks = await db
  //       .query(tasksTableName, where: 'task_date = ?', whereArgs: [date]);
  //   return tasks.map((task) => Task.fromJson(task)).toList();
  // }

  // /*
  //   Retrieve Tasks By Specified 'date' and 'status' from 'tasks' Table
  // */
  // Future<List<Task>> loadByDateAndStatus(String date, int status) async {
  //   var db = await databaseService.getDatabase();
  //   var tasks = await db.query(tasksTableName,
  //       where: 'task_date = ? AND completed = ?',
  //       whereArgs: [date, status]);
  //   return tasks.map((task) => Task.fromJson(task)).toList();
  // }

  // /*
  //   Update completed value of specific 'id' in 'tasks' Table
  // */
  // Future<int> updateCompleted(int id, int isCompleted) async{
  //   var db = await databaseService.getDatabase();
  //   return db.rawUpdate(updateTaskCompleted, [isCompleted, id]);
  // }

  // /*
  //   Delete a specific task
  // */
  // Future<int> delete(int id) async{
  //   var db = await databaseService.getDatabase();
  //   return db.delete(tasksTableName, where: "id = ?", whereArgs: [id]);
  // }
}
