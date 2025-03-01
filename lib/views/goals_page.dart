import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controller/goals_controller.dart';
import 'package:todo/views/widgets/goal_list.dart';

class GoalsPage extends StatefulWidget {
  const GoalsPage({super.key});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  final goalsController = Get.put(GoalsController(repo: Get.find()));

  @override
  Widget build(BuildContext context) {
    
    // TODO: implement Goals Page design
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Goals'.tr,
          style: context.textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      body: const GoalList(),
    );
  }
}
