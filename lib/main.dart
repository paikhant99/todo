import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo/controller/goals_controller.dart';
import 'package:todo/controller/tasks_controller.dart';
import 'package:todo/data/persistence/goal_dao.dart';
import 'package:todo/data/repository/goal_repository.dart';
import 'package:todo/data/repository/task_repository.dart';
import 'package:todo/data/persistence/db_service.dart';
import 'package:todo/data/persistence/task_dao.dart';
import 'package:todo/views/home_screen.dart';

Locale locale = const Locale('en', 'GB');
late SQLiteDatabaseService databaseService;

void main({SQLiteDatabaseService? dbService}) async {
  databaseService = dbService ?? SQLiteDatabaseService();
  Get.put(TaskDao(databaseService: databaseService));
  Get.put(GoalDao(databaseService: databaseService));
  Get.put(TaskRepository(taskDao: Get.find()));
  Get.put(GoalRepository(goalDao: Get.find()));
  Get.put(TasksController(repo: Get.find()));
  Get.put(GoalsController(repo: Get.find()));

  runApp(const Up2TaskApp());
}

class Up2TaskApp extends StatefulWidget {
  const Up2TaskApp({super.key});

  @override
  State<Up2TaskApp> createState() => _Up2TaskAppState();
}

class _Up2TaskAppState extends State<Up2TaskApp> {
  @override
  void dispose() {
    super.dispose();
    databaseService.close();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: locale,
      debugShowCheckedModeBanner: true,
      home: const HomeScreen(),
      builder: EasyLoading.init(),
      title: 'Up2Task',
    );
  }
}
