import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/models.dart';
import 'package:todo/viewmodels.dart';

class UncompletedTasksHomePage extends StatefulWidget {
  const UncompletedTasksHomePage({super.key});

  @override
  State<UncompletedTasksHomePage> createState() =>
      _UncompletedTasksHomePageState();
}

class _UncompletedTasksHomePageState extends State<UncompletedTasksHomePage> {
  /*
    Comments - 
  */

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UncompletedTasksHomePageViewModel>(context, listen: false)
          .loadTasks(DateFormat('M/d/y').format(DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UncompletedTasksHomePageViewModel>(
        builder: (context, tasksViewModel, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 100,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/all_tasks').then((_) {
                          Provider.of<UncompletedTasksHomePageViewModel>(
                                  context,
                                  listen: false)
                              .loadTasks(
                                  DateFormat('M/d/y').format(DateTime.now()));
                        });
                      },
                      child: const Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('All'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 100,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/completed_all_tasks')
                            .then((_) {
                          Provider.of<UncompletedTasksHomePageViewModel>(
                                  context,
                                  listen: false)
                              .loadTasks(
                                  DateFormat('M/d/y').format(DateTime.now()));
                        });
                      },
                      child: const Card(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Completed'),
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Today, Ongoing',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: tasksViewModel.uncompletedTasks.length,
                itemBuilder: (context, index) {
                  return TaskItemTile(
                    task: tasksViewModel.uncompletedTasks.reversed
                        .toList()[index],
                    onChanged: (taskChangedValue) {
                      Provider.of<UncompletedTasksHomePageViewModel>(context,
                              listen: false)
                          .toggleTask(
                              tasksViewModel.uncompletedTasks.reversed
                                  .toList()[index]
                                  .taskId!,
                              taskChangedValue,
                              tasksViewModel.uncompletedTasks.reversed
                                  .toList()[index]
                                  .taskDate);
                    },
                    onDeleted: () {
                      Provider.of<UncompletedTasksHomePageViewModel>(context,
                              listen: false)
                          .removeTask(
                              tasksViewModel.uncompletedTasks.reversed
                                  .toList()[index]
                                  .taskId!,
                              tasksViewModel.uncompletedTasks.reversed
                                  .toList()[index]
                                  .taskDate);
                      Navigator.of(context).pop();
                    },
                  );
                }),
          ),
        ],
      );
    });
  }
}

class TaskItemTile extends StatelessWidget {
  /*
    Comments - 
    TODO: Add subtitles for time and date showing
  */

  final Task task;
  var onChanged, onDeleted;

  TaskItemTile(
      {super.key,
      required this.task,
      required this.onChanged,
      required this.onDeleted});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: const Text('Are you sure to delete?'),
                content: Text(task.taskDesc),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Cancel')),
                  ElevatedButton(
                      onPressed: onDeleted, child: const Text('Sure'))
                ],
              );
            });
      },
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        title: Text(task.taskDesc),
        subtitle: task.taskTime == null ? null : Text(task.taskTime!),
        value: task.isCompleted == 1,
        onChanged: onChanged,
      ),
    );
  }
}
