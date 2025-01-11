import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/all_tasks_viewmodel.dart';
import 'package:todo/constants.dart';
import 'package:todo/persistence/task.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker({super.key});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late final DatePickerController _datePickerController;
  late DateTime _indexedDateTime, _selectedDateTime;

  @override
  void initState() {
    super.initState();
    _indexedDateTime = DateTime(DateTime.now().year, DateTime.now().month);
    _selectedDateTime = DateTime.now();
    _datePickerController = DatePickerController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _datePickerController.jumpToSelection();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextButton.icon(onPressed: (){
                setState(() {
                  _indexedDateTime = (_indexedDateTime.month == 1)? DateTime(_indexedDateTime.year-1, 12) : DateTime(_indexedDateTime.year, _indexedDateTime.month-1);
                  _selectedDateTime = ((_indexedDateTime.month == DateTime.now().month) & (_indexedDateTime.year == DateTime.now().year))? DateTime.now(): _indexedDateTime;
                });
              }, label: const Text(PREV_MONTH_TAB_LABEL),
              icon: const Icon(Icons.arrow_back),),
              TextButton.icon(onPressed: (){
                setState(() {
                  _indexedDateTime = (_indexedDateTime.month == 12)? DateTime(_indexedDateTime.year+1, 1) : DateTime(_indexedDateTime.year, _indexedDateTime.month+1);
                  _selectedDateTime = ((_indexedDateTime.month == DateTime.now().month) & (_indexedDateTime.year == DateTime.now().year))? DateTime.now(): _indexedDateTime;
                  
                });
              }, label: const Text(NEXT_MONTH_TAB_LABEL),
              icon: const Icon(Icons.arrow_forward),
              iconAlignment: IconAlignment.end),
            ],
          ),
        ),
        DatePicker(
          _indexedDateTime,
          controller: _datePickerController,
          height: 100,
          initialSelectedDate: _selectedDateTime,
          daysCount: 30,
          selectionColor: Colors.blueAccent,
          selectedTextColor: Colors.white,
          onDateChange: (date) {
            Provider.of<AllTasksViewModel>(context, listen: false)
                .loadTasks(DateFormat('M/d/y').format(date));
          },
        ),
      ],
    );
  }
}
