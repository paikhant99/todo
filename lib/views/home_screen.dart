import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/models.dart';
import 'package:todo/viewmodels.dart';
import 'package:todo/views/notes_page.dart';
import 'package:todo/views/uncompleted_tasks_home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /*
    Comments - 
  */
  int currentPageIndex = 0;
  static const List<Widget> _tabs = [UncompletedTasksHomePage(), NotesPage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text('Facere'),
        ),
        body: _tabs[currentPageIndex],
        floatingActionButton: FloatingActionButton(
          shape: const CircleBorder(),
          child: const Icon(Icons.add),
          onPressed: () {
            showModalBottomSheet(
                useSafeArea: true,
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return const AddNewTaskBottomSheet();
                });
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 6,
          child: NavigationBar(
            onDestinationSelected: (int index) {
              setState(() {
                currentPageIndex = index;
              });
            },
            selectedIndex: currentPageIndex,
            destinations: const [
              NavigationDestination(icon: Icon(Icons.task), label: "Tasks"),
              NavigationDestination(icon: Icon(Icons.notes), label: "Notes")
            ],
          ),
        ));
  }
}

class AddNewTaskBottomSheet extends StatefulWidget {
  const AddNewTaskBottomSheet({super.key});

  @override
  State<AddNewTaskBottomSheet> createState() => _AddNewTaskBottomSheetState();
}

class _AddNewTaskBottomSheetState extends State<AddNewTaskBottomSheet> {
  /*
    Comments - 
  */

  String _timeChosen = "Choose Time";
  var _endTimeChosen = "Choose Time";
  String _dateChosen = DateFormat('M/d/y').format(DateTime.now());
  final TextEditingController _txtEditController = TextEditingController();
  var _endTimeBoxEnabled = false;
  final _frequencies = ['None', 'Every Week'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: DraggableScrollableSheet(
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text('Title'),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      autofocus: true,
                      controller: _txtEditController,
                      decoration: const InputDecoration(filled: true),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Date'),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
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
                        child: Text(_dateChosen)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ExpandablePanel(
                        header: const Text('Time'),
                        collapsed: Container(),
                        expanded: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('Start Time'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          onPressed: () async {
                                            var timeChosen =
                                                await showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                        TimeOfDay.now());
                                            setState(() {
                                              if (timeChosen != null) {
                                                _timeChosen =
                                                    timeChosen.format(context);
                                              }
                                            });
                                          },
                                          child: Text(_timeChosen)),
                                    )
                                  ],
                                ),
                                Center(
                                    child: Checkbox(
                                        value: _endTimeBoxEnabled,
                                        onChanged: (value) {
                                          setState(() {
                                            _endTimeBoxEnabled =
                                                !_endTimeBoxEnabled;
                                            _endTimeChosen = "Choose Time";
                                          });
                                        })),
                                Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text('End Time'),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                          onPressed: _endTimeBoxEnabled
                                              ? () async {
                                                  var timeChosen =
                                                      await showTimePicker(
                                                          context: context,
                                                          initialTime:
                                                              TimeOfDay.now());
                                                  setState(() {
                                                    if (timeChosen != null) {
                                                      _endTimeChosen =
                                                          timeChosen
                                                              .format(context);
                                                    }
                                                  });
                                                }
                                              : null,
                                          child: Text(_endTimeChosen)),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                const Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text('Repeated'),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton(
                                      value: _frequencies.first,
                                      items: _frequencies
                                          .map<DropdownMenuItem<String>>(
                                              (value) {
                                        return DropdownMenuItem<String>(
                                            value: value, child: Text(value));
                                      }).toList(),
                                      onChanged: (value) {}),
                                )
                              ],
                            ),
                          ],
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Provider.of<UncompletedTasksHomePageViewModel>(
                                  context,
                                  listen: false)
                              .addTask(
                                  _txtEditController.text.isEmpty
                                      ? null
                                      : Task(
                                          taskId: null,
                                          taskDesc: _txtEditController.text,
                                          taskDate: _dateChosen,
                                          taskTime: _timeChosen == 'Choose Time'
                                              ? null
                                              : _timeChosen,
                                          isCompleted: 0),
                                  _dateChosen);
                          Navigator.pop(context);
                        },
                        child: const Text('CREATE TASK')),
                  ),
                ],
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _txtEditController.dispose();
  }
}
