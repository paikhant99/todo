import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/constants.dart';
import 'package:todo/controller/tasks_controller.dart';
import 'package:todo/persistence/task.dart';

class TaskItemCard extends StatefulWidget {
  /*
    Comments - 
  */

  final Task task;

  const TaskItemCard({super.key, required this.task});

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {
  final tasksController = Get.put(TasksController());

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text(DELETE_CONFIRMATION_MSG),
                content: Text(widget.task.taskName),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(CANCEL_BUTTON_LABEL)),
                  ElevatedButton(
                      onPressed: () {
                        // Provider.of<AllTasksViewModel>(context, listen: false)
                        //     .removeTask(task.taskId!, task.taskDate);
                        Navigator.of(context).pop();
                      },
                      child: const Text(CONFIRM_BUTTON_LABEL))
                ],
              );
            });
      },
      child: Card(
        child: CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(widget.task.taskName),
          subtitle: Text(widget.task.goalName),
          value: widget.task.isCompleted,
          onChanged: (value) {
            setState(() {
              widget.task.isCompleted = value!;
            });
            tasksController.updateTaskCheck(widget.task);
            // Provider.of<AllTasksViewModel>(context, listen: false)
            //     .toggleTask(task.taskId!, value!, task.taskDate);
          },
        ),
      ),
    );
  }
}