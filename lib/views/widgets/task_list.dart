import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controller/tasks_controller.dart';
import 'package:todo/data/entity/task.dart';
import 'package:todo/views/widgets/task_item_card.dart';

class TaskList extends StatefulWidget {
  final bool isCompleted;
  TaskList({super.key, required this.isCompleted});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final tasksController = Get.find<TasksController>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement tasks list design

    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Obx(
        () {
          RxList<Task> tasks = <Task>[].obs;
          List<Task> filteredList = tasksController.tasks
              .where((task) => task.isCompleted == widget.isCompleted)
              .toList();
          tasks.value = filteredList.obs;

          return ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                return TaskItemCard(task: tasks[index]);
              });
        },
      ),
    );
  }
}
