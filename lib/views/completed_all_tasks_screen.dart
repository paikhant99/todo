import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/viewmodels.dart';
import 'package:todo/views/uncompleted_tasks_home_page.dart';

class CompletedAllTasksScreen extends StatefulWidget {
  const CompletedAllTasksScreen({super.key});

  @override
  State<CompletedAllTasksScreen> createState() =>
      _CompletedAllTasksScreenState();
}

class _CompletedAllTasksScreenState extends State<CompletedAllTasksScreen> {
  /*
    Comments -
  */

  final DatePickerController _datePickerController = DatePickerController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _datePickerController.jumpToSelection();
      Provider.of<CompletedAllTasksScreenViewModel>(context, listen: false)
          .loadTasks(DateFormat('M/d/y').format(DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Facerer'),
      ),
      body: Consumer<CompletedAllTasksScreenViewModel>(
          builder: (context, completedTasksViewModel, child) {
        return Column(
          children: [
            DatePicker(
              DateTime(DateTime.now().year, DateTime.now().month),
              controller: _datePickerController,
              height: 100,
              initialSelectedDate: DateTime.now(),
              daysCount: 30,
              selectionColor: Colors.black,
              selectedTextColor: Colors.white,
              onDateChange: (date) {
                Provider.of<CompletedAllTasksScreenViewModel>(context,
                        listen: false)
                    .loadTasks(DateFormat('M/d/y').format(date));
              },
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: completedTasksViewModel.completedTasks.length,
                  itemBuilder: (context, index) {
                    return TaskItemTile(
                      task: completedTasksViewModel.completedTasks.reversed
                          .toList()[index],
                      onChanged: (taskChangedValue) {
                        Provider.of<CompletedAllTasksScreenViewModel>(context,
                                listen: false)
                            .toggleTask(
                                completedTasksViewModel.completedTasks.reversed
                                    .toList()[index]
                                    .taskId!,
                                taskChangedValue,
                                completedTasksViewModel.completedTasks.reversed
                                    .toList()[index]
                                    .taskDate);
                      },
                      onDeleted: () {
                        Provider.of<CompletedAllTasksScreenViewModel>(context,
                                listen: false)
                            .removeTask(
                                completedTasksViewModel.completedTasks.reversed
                                    .toList()[index]
                                    .taskId!,
                                completedTasksViewModel.completedTasks.reversed
                                    .toList()[index]
                                    .taskDate);
                        Navigator.of(context).pop();
                      },
                    );
                  }),
            )
          ],
        );
      }),
    );
  }
}
