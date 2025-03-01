import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/views/widgets/goal_list.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({super.key});

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
