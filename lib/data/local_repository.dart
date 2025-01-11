/*
  Reminder - This service only available in macOs, android, IOS
*/

import 'package:todo/data/entity/task.dart';
import 'package:todo/data/persistence/task_dao.dart';

class LocalRepository {
  /*
    Comments -
  */

  TaskDao taskDao;

  LocalRepository({required this.taskDao});

  // (Create Task) : Create a new pop up task
  Future<int> createTask(Task task) {
    return taskDao.create(task);
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