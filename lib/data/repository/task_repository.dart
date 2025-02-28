/*
  Reminder - This service only available in macOs, android, IOS
*/

import 'package:todo/data/entity/task.dart';
import 'package:todo/data/persistence/task_dao.dart';

class TaskRepository {
  /*
    Comments -
  */

  TaskDao taskDao;

  TaskRepository({required this.taskDao});

  // (Create Task) : Create a new pop up task
  Future<int> createTask(Task task) {
    return taskDao.create(task);
  }

  // (Load All Tasks) : Load all tasks
  Future<List<Task>> loadAllTasks() {
    return taskDao.readAllUnarchivedTasks();
  }

  // (Mark Task Check) : Mark Task Completion as completed or in_progress
  Future<int> markTaskCheck(int taskId, bool checked) {
    return checked
        ? taskDao.markCompleted(taskId)
        : taskDao.markInProgress(taskId);
  }

  // (Archive Tasks) : Archive tasks by setting archived_at attribute with current timestamp
  Future<List<int>> archiveTasks(List<int> ids) {
    return taskDao.archiveTasks(ids);
  }

  // Future<List<Task>> loadAllTasksByDate(String date) {
  //   return taskDao.loadByDate(date);
  // }

  // Future<List<Task>> loadUnCompletedTasksByDate(String date) {
  //   return taskDao.loadByDateAndStatus(date, 0);
  // }

  // Future<List<Task>> loadCompletedTasksByDate(String date) {
  //   return taskDao.loadByDateAndStatus(date, 1);
  // }

  // Future<int> updateTaskCompletion(int taskId, int isCompleted) {
  //   return taskDao.updateCompleted(taskId, isCompleted);
  // }

  // Future<int> deleteTask(int taskId) {
  //   return taskDao.delete(taskId);
  // }
}
