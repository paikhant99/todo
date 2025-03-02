import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:todo/controller/goals_controller.dart';
import 'package:todo/controller/tasks_controller.dart';
import 'package:todo/data/entity/task.dart';

class TaskItemCard extends StatefulWidget {
  final Task task;
  final int index;
  final Function() onTap;
  final Function() onLongPress;

  const TaskItemCard(
      {super.key,
      required this.task,
      required this.index,
      required this.onTap,
      required this.onLongPress});

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {
  /*
    Comments - 
  */

  final tasksController = Get.find<TasksController>();
  final goalsController = Get.find<GoalsController>();

  //TODO: Add (On changed - Event) : call updateTaskCheck from tasksController
  void _onChanged(bool? value) {
    setState(() {
      widget.task.isCompleted = value!;
      tasksController.updateTaskCheck(widget.task.taskId!, value);
      goalsController.fetchGoals();
    });
  }

  // (Build) : Build Task Item UI Card
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onLongPress: widget.onLongPress,
      child: Obx(() {
        return Card(
          shape: tasksController.selectedTasks.contains(widget.task) &&
                  tasksController.isMultipleSelected.isTrue
              ? RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                  side: BorderSide(
                      color: tasksController.selectedTasks.contains(widget.task)
                          ? Colors.green
                          : Colors.transparent,
                      width: 2))
              : null,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Checkbox(
                    key: Key("completedCheckbox_${widget.index}"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    value: widget.task.isCompleted,
                    onChanged: tasksController.isMultipleSelected.isFalse
                        ? _onChanged
                        : null),
                const Gap(15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.task.taskName,
                        style: context.textTheme.bodyLarge
                            ?.copyWith(fontWeight: FontWeight.w400),
                        softWrap: true,
                      ),
                      if (widget.task.description.isNotEmpty)
                        const Icon(IconsaxPlusLinear.document_text),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      }),
    );
  }
}
