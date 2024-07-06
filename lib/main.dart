import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todo/models.dart';
import 'package:todo/persistence/local_repository.dart';
import 'package:todo/viewmodels.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp(
    db: await SQLiteDatabaseImpl().open(),
  ));
}

class MyApp extends StatefulWidget {
  Database db;

  MyApp({super.key, required this.db});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TasksViewModel(
          localRepo: LocalRepository(taskDao: TaskDao(db: widget.db)))
        ..loadTasks(),
      child: const MaterialApp(
        title: 'TODO App',
        home: HomeScreen(),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    SQLiteDatabaseImpl().close(widget.db);
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /*
    Comments - 
  */
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TasksViewModel>(builder: (context, tasksModel, child) {
      return Scaffold(
          resizeToAvoidBottomInset: true,
          body: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: tasksModel.tasks.length,
                    itemBuilder: (context, index) {
                      print("Main dart : ${tasksModel.tasks}");
                      return TaskItemTile(
                          task: tasksModel.tasks.reversed.toList()[index]);
                    }),
              ),
              BottomAddNewTaskField(
                isVisible: tasksModel.isAddTaskFieldVisible,
                focusNode: _focusNode,
              )
            ],
          ),
          floatingActionButton: !tasksModel.isAddTaskFieldVisible
              ? FloatingActionButton(
                  shape: const CircleBorder(),
                  child: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      Provider.of<TasksViewModel>(context, listen: false)
                          .setAddTaskFieldVisible(true);
                      _focusNode.requestFocus();
                    });
                  },
                )
              : null);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }
}

class BottomAddNewTaskField extends StatefulWidget {
  final FocusNode focusNode;
  final bool isVisible;

  const BottomAddNewTaskField(
      {super.key, required this.isVisible, required this.focusNode});

  @override
  State<BottomAddNewTaskField> createState() => _BottomAddNewTaskFieldState();
}

class _BottomAddNewTaskFieldState extends State<BottomAddNewTaskField> {
  /*
    Comments - 
  */
  String _timeChosen = "Choose Time";
  String _dateChosen = DateFormat('EEE, M/d/y').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.isVisible,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () async {
                    var dateChosen = await showDatePicker(
                        context: context,
                        firstDate: DateTime.now(),
                        lastDate: DateTime(DateTime.now().year + 10),
                        initialDate: DateTime.now());
                    setState(() {
                      if (dateChosen != null) {
                        _dateChosen =
                            DateFormat('EEE, M/d/y').format(dateChosen);
                      }
                    });
                  },
                  child: Text('Date - $_dateChosen'),
                ),
              ),
              Expanded(
                child: TextButton(
                    onPressed: () async {
                      var timeChosen = await showTimePicker(
                          context: context, initialTime: TimeOfDay.now());
                      setState(() {
                        if (timeChosen != null) {
                          _timeChosen = timeChosen.format(context);
                        }
                      });
                    },
                    child: Text(_timeChosen)),
              )
            ],
          ),
          TextField(
              focusNode: widget.focusNode,
              decoration: const InputDecoration(
                hintText: "Write Task",
                border: OutlineInputBorder(),
              ),
              onSubmitted: (value) =>
                  Provider.of<TasksViewModel>(context, listen: false).addTask(
                      value.isEmpty
                          ? null
                          : Task(
                              taskId: null,
                              taskDesc: value,
                              taskDate: _dateChosen,
                              taskTime: _timeChosen == 'Choose Time'
                                  ? null
                                  : _timeChosen,
                              isCompleted: 0))),
        ],
      ),
    );
  }
}

class TaskItemTile extends StatelessWidget {
  /*
    Comments - 
    TODO: Add subtitles for time and date showing
  */

  final Task task;

  const TaskItemTile({super.key, required this.task});

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
                      onPressed: () {
                        Provider.of<TasksViewModel>(context, listen: false)
                            .removeTask(task.taskId!);
                        Navigator.of(context).pop();
                      },
                      child: const Text('Sure'))
                ],
              );
            });
        print("Main dart : delete func worked");
      },
      child: CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(task.taskDesc),
          subtitle: task.taskTime == null ? null : Text(task.taskTime!),
          value: task.isCompleted == 1,
          onChanged: (value) {
            Provider.of<TasksViewModel>(context, listen: false)
                .toggleTask(task.taskId!, value!);
          }),
    );
  }
}
