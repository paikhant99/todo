import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:todo/controller/tasks_controller.dart';
import 'package:todo/data/entity/task.dart';

class TaskItemCard extends StatefulWidget {
  final Task task;

  const TaskItemCard({super.key, required this.task});

  @override
  State<TaskItemCard> createState() => _TaskItemCardState();
}

class _TaskItemCardState extends State<TaskItemCard> {
  /*
    Comments - 
  */

  final tasksController = Get.find<TasksController>();

  // TODO: (On Tap - Event) : Appear Editing Task Action Screen
  void _onTap() {}

  // TODO: (On Long Press - Event) : Add Multi-select Action
  void _onLongPress() {}

  //TODO: Add (On changed - Event) : call updateTaskCheck from tasksController
  void _onChanged(bool? value) {
    setState(() {
      widget.task.isCompleted = value!;
    });
  }

  // (Build) : Build Task Item UI Card
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _onTap,
      onLongPress: _onLongPress,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              Checkbox(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  value: widget.task.isCompleted,
                  onChanged: _onChanged),
              const Gap(15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.task.taskName,
                    style: context.textTheme.bodyLarge
                        ?.copyWith(fontWeight: FontWeight.w400),
                  ),
                  Row(
                    children: [
                      widget.task.description.isNotEmpty
                          ? const Icon(IconsaxPlusLinear.document_text)
                          : const Offstage()
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
