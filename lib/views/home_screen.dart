import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:todo/views/goals_page.dart';
import 'package:todo/views/tasks_page.dart';
import 'package:todo/views/widgets/tasks_action.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /*
    Comments - 
  */
  // TODO : Change Home Screen design

  int pageIndex = 0;
  static final UnmodifiableListView<Widget> _tabs = UnmodifiableListView([
    const TasksPage(
      title: "Backlog",
    ),
    const GoalsPage()
  ]);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        body: IndexedStack(
          index: pageIndex,
          children: _tabs,
        ),
        floatingActionButton: FloatingActionButton(
          key: const Key('addFAB'),
          shape: const CircleBorder(),
          child: const Icon(IconsaxPlusLinear.add),
          onPressed: () {
            showModalBottomSheet(
                useSafeArea: true,
                isScrollControlled: true,
                context: context,
                builder: (context) {
                  return TaskAction(text: 'create'.tr, edit: false);
                });
          },
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 6,
          child: NavigationBar(
            onDestinationSelected: (int index) {
              setState(() {
                pageIndex = index;
              });
            },
            selectedIndex: pageIndex,
            destinations: const [
              NavigationDestination(
                  selectedIcon: Icon(IconsaxPlusBold.task_square),
                  icon: Icon(IconsaxPlusLinear.task_square),
                  label: "Backlog"),
              NavigationDestination(
                  key: Key('goalsNavTab'),
                  selectedIcon: Icon(IconsaxPlusBold.folder),
                  icon: Icon(IconsaxPlusLinear.folder),
                  label: "Goals"),
            ],
          ),
        ));
  }
}
