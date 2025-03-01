import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controller/tasks_controller.dart';
import 'package:todo/data/entity/task.dart';
import 'package:todo/views/widgets/task_item_card.dart';

class TaskList extends StatefulWidget {
  final bool isCompleted;
  const TaskList({super.key, required this.isCompleted});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final tasksController = Get.find<TasksController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Obx(
        () {
          RxList<Task> tasks = <Task>[].obs;
          List<Task> filteredList = tasksController.tasks
              .where((task) => task.isCompleted == widget.isCompleted)
              .toList();
          tasks.value = filteredList.obs;

          return ListView(
            children: [
              ...tasks.map((task) {
                return TaskItemCard(
                  task: task,
                  index: tasks.indexOf(task),
                  onTap: () {
                    // tasksController.isMultipleSelected.value = true;
                    tasksController.doMultipleSelection(task);
                  },
                  onLongPress: () {
                    tasksController.isMultipleSelected.value = true;
                    tasksController.doMultipleSelection(task);
                  },
                );
              })
            ],
          );
        },
      ),
    );
  }
}
