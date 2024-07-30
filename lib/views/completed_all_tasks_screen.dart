import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/all_tasks_viewmodel.dart';
import 'package:todo/views/customs.dart';

class CompletedAllTasksScreen extends StatelessWidget {
  const CompletedAllTasksScreen({super.key});

  /*
    Comments -
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facerer'),
      ),
      body: Column(
        children: [
          const CustomDatePicker(),
          Expanded(child: Consumer<AllTasksViewModel>(
              builder: (context, allTasksViewModel, child) {
            return ListView.builder(
                itemCount: allTasksViewModel.updatedCompletedTasks.length,
                itemBuilder: (context, index) {
                  return TaskItemTile(
                    task: allTasksViewModel.updatedCompletedTasks[index],
                  );
                });
          }))
        ],
      ),
    );
  }
}
