import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo/controller/tasks_controller.dart';
import 'package:todo/persistence/task.dart';

class TaskAction extends StatefulWidget {
  final String text;
  final Task? task;
  final bool edit;
  const TaskAction(
      {super.key, required this.text, required this.edit, this.task});

  @override
  State<TaskAction> createState() => _TaskActionState();
}

class _TaskActionState extends State<TaskAction> {
  /*
    Comments - 
  */
  late final _EditingController controller;
  final tasksController = Get.put(TasksController());
  final taskNameEdit = TextEditingController();
  final taskDescEdit = TextEditingController();

  // TODO: Uncomment & Implement this when doing editing feature

  // final taskGoalController = TextEditingController();
  // final taskTimeEdit = TextEditingController();

  // TODO: Uncomment & Implement this when doing editing feature

  // List<String> getAllGoals(String pattern) {
  //   return ['Design-UI'].toList();
  // }

  // (On Pressed - Event) : Complete Task Submission and Call AddTask method from tasksController
  void onPressed() {
    tasksController.addTask(taskNameEdit.text, taskDescEdit.text);
    taskNameEdit.clear();
    taskDescEdit.clear();
    Get.back();
  }

  // (Init State) : Initialize all kinds of state
  @override
  void initState() {
    controller = _EditingController(taskNameEdit.text);
    super.initState();
  }

  // (Build) : Build the Task Action UI Page
  @override
  Widget build(BuildContext context) {
    // TODO: Uncomment & Implement this when doing editing feature

    // final taskPriorityWidget = MenuAnchor(
    //     menuChildren: Priority.values
    //         .map((priority) => MenuItemButton(
    //               leadingIcon: Icon(
    //                 IconsaxPlusLinear.flag,
    //                 color: priority.color,
    //               ),
    //               child: Text(priority.name.tr),
    //               onPressed: () {
    //                 //Implement choose priority changes
    //               },
    //             ))
    //         .toList());

    // TODO: Uncomment & Implement this when doing editing feature

    // final taskDateWidget = RawChip(
    //   label: const Text("Execution Time"),
    //   deleteIcon: const Icon(IconsaxPlusLinear.close_square),
    //   onDeleted: () {},
    // );

    // TODO: Uncomment & Implement this when doing editing feature

    // final taskGoal = RawAutocomplete<String>(fieldViewBuilder: (context,
    //     fieldTextEditingController, fieldFocusNode, onFieldSubmitted) {
    //   return Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: TextField(
    //       controller: taskGoalController,
    //       keyboardType: TextInputType.text,
    //       autofocus: true,
    //       decoration:
    //           InputDecoration(filled: true, label: Text('Select Goal'.tr)),
    //     ),
    //   );
    // }, onSelected: (String selection) {
    //   taskGoalController.text = selection;

    //   setState(() {

    //   });
    // }, optionsViewBuilder: (context, onSelected, options) {
    //   return ListView.builder(itemBuilder: (context, index) {
    //     final String goal = options.elementAt(index);
    //     return InkWell(
    //       onTap: () => onSelected(goal),
    //       child: ListTile(
    //         title: Text(goal),
    //       ),
    //     );
    //   });
    // }, optionsBuilder: (TextEditingValue textEditingValue) {
    //   if (textEditingValue.text.isEmpty) {
    //     return const Iterable<String>.empty();
    //   }
    //   print(textEditingValue.text);
    //   return getAllGoals(textEditingValue.text);
    // });

    // TODO: Uncomment & Implement this when doing editing feature

    // final attributes = Row(
    //   children: [taskDateWidget, const Gap(10), taskPriorityWidget],
    // );

    // TextField : Name Prompt Box
    final taskNameInput = Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        key: const Key('taskNameInput'),
        autofocus: true,
        controller: taskNameEdit,
        onChanged: (value) => controller.name.value = value,
        decoration: InputDecoration(filled: true, label: Text('Name'.tr)),
      ),
    );

    // TextField : Description Prompt Box
    final descriptionInput = Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        key: const Key('taskDescriptionInput'),
        autofocus: true,
        controller: taskDescEdit,
        decoration:
            InputDecoration(filled: true, label: Text('Description'.tr)),
      ),
    );

    // Button : Done Action
    final submitButton = ValueListenableBuilder(
        valueListenable: controller.canSubmit,
        builder: (context, canSubmit, _) {
          return ElevatedButton(
            key: const Key('doneButton'),
              onPressed: canSubmit ? () => onPressed() : null,
              child: Text('Done'.tr));
        });

    // UI Built : - Return SingleChildScrollView
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text,
              textAlign: TextAlign.center,
              style: context.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            taskNameInput,
            descriptionInput,
            submitButton
          ],
        ),
      ),
    );
  }

  // (Dispose) : Dispose all controllers
  @override
  void dispose() {
    taskNameEdit.dispose();
    taskDescEdit.dispose();

    // TODO: Uncomment & Implement this when doing editing feature

    // taskGoalController.dispose();
    // taskTimeEdit.dispose();

    super.dispose();
  }
}

class _EditingController extends ChangeNotifier {
  // (Constructor) : Set up Constructor defining initial values and listener
  _EditingController(this.initialName) {
    name.value = initialName;
    name.addListener(_updateCanSubmit);
  }

  final String? initialName;
  final name = ValueNotifier<String?>(null);

  final _canSubmit = ValueNotifier(false);
  ValueListenable<bool> get canSubmit => _canSubmit;

  // (UpdateCanSubmit) : Update canSubmit Every time name and description is listened.
  void _updateCanSubmit() {
    _canSubmit.value = (name.value != initialName);
  }

  // (Dispose) : Dispose Listener for all Notifiers
  @override
  void dispose() {
    name.removeListener(_updateCanSubmit);
    super.dispose();
  }
}
