import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controller/goals_controller.dart';
import 'package:todo/controller/tasks_controller.dart';
import 'package:todo/data/entity/goal.dart';
import 'package:todo/views/tasks_page.dart';
import 'package:todo/views/widgets/goal_item_card.dart';

class GoalList extends StatefulWidget {
  const GoalList({super.key});

  @override
  State<GoalList> createState() => _GoalListState();
}

class _GoalListState extends State<GoalList> {
  final goalsController = Get.find<GoalsController>();
  final tasksController = Get.find<TasksController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    goalsController.fetchGoals();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Obx(() {
        RxList<Goal> goals = <Goal>[].obs;
        List<Goal> filteredList = goalsController.goals.toList();
        goals.value = filteredList.obs;
        return ListView(
          children: [
            ...goals.map((goal) {
              return GoalItemCard(
                goal: goal,
                percent: goal.allTasksCount == 0
                    ? 0
                    : goal.completedTasksCount / goal.allTasksCount,
                onTap: () {
                  Get.to(TasksPage(
                    title: goal.goalName,
                    goalId: goal.goalId!,
                  ))?.then((value) {
                    tasksController.fetchTasks();
                  });
                },
              );
            }),
          ],
        );
      }),
    );
  }
}
