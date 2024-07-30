
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/views/customs.dart';
import 'package:todo/all_tasks_viewmodel.dart';

class OnProgressTasksPage extends StatefulWidget {
  const OnProgressTasksPage({super.key});

  @override
  State<OnProgressTasksPage> createState() =>
      _OnProgressTasksPageState();
}

class _OnProgressTasksPageState extends State<OnProgressTasksPage> {
  /*
    Comments - 
  */

  double progressValue = 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AllTasksViewModel>(context, listen: false)
          .loadTasks(DateFormat('M/d/y').format(DateTime.now()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AllTasksViewModel>(
        builder: (context, tasksViewModel, child) {
          progressValue = (tasksViewModel.updatedAllTasks.isNotEmpty)? ((tasksViewModel.updatedAllTasks.length - tasksViewModel.updatedUncompletedTasks.length) / tasksViewModel.updatedAllTasks.length) : progressValue;
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 140,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/completed_all_tasks')
                            .then((_) {
                          Provider.of<AllTasksViewModel>(
                                  context,
                                  listen: false)
                              .loadTasks(
                                  DateFormat('M/d/y').format(DateTime.now()));
                        });
                      },
                      child: Card(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                "Today's Progress Summary",
                                style: TextStyle(fontSize: 20)
                                ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                children: [
                                  Text("${tasksViewModel.updatedAllTasks.length} Tasks"),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.all(8.0),
                                                child: Text('Progress'),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text('${(progressValue * 100).toInt()} %'),
                                              )
                                            ],
                                          ),
                                          LinearProgressIndicator(
                                            semanticsLabel: "Progress Bar",
                                            value: progressValue,
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
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
              'On Progress',
              style: TextStyle(fontSize: 20),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: tasksViewModel.updatedUncompletedTasks.length,
                itemBuilder: (context, index) {
                  return TaskItemTile(
                    task: tasksViewModel.updatedUncompletedTasks[index],
                  );
                }),
          ),
        ],
      );
    });
  }
}

