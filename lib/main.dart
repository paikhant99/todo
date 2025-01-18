import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:todo/controller/tasks_controller.dart';
import 'package:todo/data/repository/task_repository.dart';
import 'package:todo/data/persistence/db_service.dart';
import 'package:todo/data/persistence/task_dao.dart';
import 'package:todo/views/home_screen.dart';

Locale locale = const Locale('en', 'GB');

void main() async {

  final dbService = SQLiteDatabaseService();
  Get.put(TaskDao(databaseService: dbService));
  Get.put(TaskRepository(taskDao: Get.find()));
  Get.put(TasksController(repo: Get.find()));

  runApp(const Up2TaskApp());
}

class Up2TaskApp extends StatelessWidget {
  const Up2TaskApp({super.key});

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
