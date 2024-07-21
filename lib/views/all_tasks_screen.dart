import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/viewmodels.dart';
import 'package:todo/views/uncompleted_tasks_home_page.dart';

class AllTasksScreen extends StatefulWidget {
  const AllTasksScreen({super.key});

  @override
  State<AllTasksScreen> createState() => _AllTasksScreenState();
}

class _AllTasksScreenState extends State<AllTasksScreen> {
  final DatePickerController _datePickerController = DatePickerController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _datePickerController.jumpToSelection();
      Provider.of<AllTasksScreenViewModel>(context, listen: false)
          .loadTasks(DateFormat('M/d/y').format(DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Facerer')),
      body: Consumer<AllTasksScreenViewModel>(
          builder: (context, allTasksScreenViewModel, child) {
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
                Provider.of<AllTasksScreenViewModel>(context, listen: false)
                    .loadTasks(DateFormat('M/d/y').format(date));
              },
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: allTasksScreenViewModel.allTasks.length,
                  itemBuilder: (context, index) {
                    return TaskItemTile(
                      task: allTasksScreenViewModel.allTasks.reversed
                          .toList()[index],
                      onChanged: (taskChangedValue) {
                        Provider.of<AllTasksScreenViewModel>(context,
                                listen: false)
                            .toggleTask(
                                allTasksScreenViewModel.allTasks.reversed
                                    .toList()[index]
                                    .taskId!,
                                taskChangedValue,
                                allTasksScreenViewModel.allTasks.reversed
                                    .toList()[index]
                                    .taskDate);
                      },
                      onDeleted: () {
                        Provider.of<AllTasksScreenViewModel>(context,
                                listen: false)
                            .removeTask(
                                allTasksScreenViewModel.allTasks.reversed
                                    .toList()[index]
                                    .taskId!,
                                allTasksScreenViewModel.allTasks.reversed
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
