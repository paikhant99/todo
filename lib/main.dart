import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TODO App',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget{

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Task> _taskItems = [];

  var _addNewTaskShow = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode = FocusNode();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _taskItems.length,
              itemBuilder: (context, index) {
                return TaskItemTile(task: _taskItems[index]);
              }
            ),
          ),
          BottomAddNewTaskField(
            isVisible: _addNewTaskShow,
            focusNode: _focusNode, 
            onSubmittedTask: (value){
              setState(() {
                if (value != null){
                  _taskItems.add(value);
                }
                _addNewTaskShow = !_addNewTaskShow;
                _focusNode.unfocus();
              });
              
            },)
        ],
      ),
      floatingActionButton: !_addNewTaskShow? FloatingActionButton(
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
        onPressed: (){
          setState(() {
            _addNewTaskShow = !_addNewTaskShow;
            _focusNode.requestFocus();
          });
        },
        ): null
    );
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode.dispose();
  }
}

class BottomAddNewTaskField extends StatefulWidget{

  final FocusNode focusNode;
  final bool isVisible;
  final onSubmittedTask;

  const BottomAddNewTaskField({super.key, required this.isVisible, required this.focusNode, required this.onSubmittedTask});

  @override
  State<BottomAddNewTaskField> createState() => _BottomAddNewTaskFieldState();
}

class _BottomAddNewTaskFieldState extends State<BottomAddNewTaskField> {

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
                    var dateChosen = await showDatePicker(context: context, firstDate: DateTime.now(), lastDate: DateTime(DateTime.now().year+10), initialDate: DateTime.now());
                    setState(() {
                      if (dateChosen != null){
                        _dateChosen = DateFormat('EEE, M/d/y').format(dateChosen);
                      }
                    });
                  },
                  child: Text('Date - $_dateChosen'),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () async {
                    var timeChosen = await showTimePicker(context: context, initialTime: TimeOfDay.now());
                    setState(() {
                      if (timeChosen != null){
                        _timeChosen = timeChosen.format(context);
                      }
                    });
                  },
                  child: Text(_timeChosen)
                ),
              )
            ],
          ),
          TextField(
            focusNode: widget.focusNode,
            decoration: const InputDecoration(
              hintText: "Write Task",
              border: OutlineInputBorder(),
            ),
            onSubmitted: (value) => widget.onSubmittedTask(value.isEmpty? null: Task(id: null,taskDesc: value, taskDate: _dateChosen, taskTime: _timeChosen == 'Choose Time'? null: _timeChosen, isCompleted: false))
          ),
        ],
      ),
    );
  }
}

class TaskItemTile extends StatefulWidget{

  final Task task;

  const TaskItemTile({super.key, required this.task});

  @override
  State<TaskItemTile> createState() => _TaskItemTileState();
}

class _TaskItemTileState extends State<TaskItemTile> {

  @override
  Widget build(BuildContext context) {
    // TODO: Add subtitles for time and date showing
    return CheckboxListTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(widget.task.taskDesc),
          subtitle: widget.task.taskTime == null? null: Text(widget.task.taskTime!),
          value: widget.task.isCompleted, 
          onChanged: (value){
            setState(() {
              widget.task.isCompleted = value!;
            });
        });
  }
}
