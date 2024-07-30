import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/all_tasks_viewmodel.dart';
import 'package:todo/views/customs.dart';

class AllTasksPage extends StatelessWidget {
  const AllTasksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomDatePicker(),
        Expanded(child: Consumer<AllTasksViewModel>(
            builder: (context, allTasksScreenViewModel, child) {
          return ListView.builder(
              itemCount: allTasksScreenViewModel.updatedAllTasks.length,
              itemBuilder: (context, index) {
                return TaskItemTile(
                  task: allTasksScreenViewModel.updatedAllTasks[index],
                );
              });
        }))
      ],
    );
  }
}
