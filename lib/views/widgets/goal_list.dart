import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/data/entity/goal.dart';
import 'package:todo/views/tasks_page.dart';
import 'package:todo/views/widgets/goal_item_card.dart';

class GoalList extends StatelessWidget {
  const GoalList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final goals = <Goal>[
      Goal(goalName: 'Backlog'),
      Goal(goalName: 'In Progress'),
      Goal(goalName: 'Completed')
    ];
    return ListView(
      children: [
        ...goals
            .map((goal) {

              

              return GoalItemCard(
                  goal: goal,
                  percent: 25,
                  onTap: () {
                    Get.to(TasksPage(
                      title: goal.goalName,
                    ));
                  },
                );
            })
            .toList(),
      ],
    );
  }
}
