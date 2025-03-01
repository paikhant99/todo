import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:todo/controller/tasks_controller.dart';
import 'package:todo/views/widgets/my_delegate.dart';
import 'package:todo/views/widgets/task_list.dart';

class TasksPage extends StatefulWidget {
  final String title;
  const TasksPage({super.key, required this.title});

  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  final tasksController = Get.find<TasksController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: Implement Tasks Page design
    return Obx(() {
      return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            leading: tasksController.isMultipleSelected.isTrue
                ? IconButton(
                    icon: const Icon(IconsaxPlusLinear.close_square),
                    onPressed: () => tasksController.clearMultipleSelection(),
                  )
                : null,
            title: Text(
              widget.title.tr,
              style: context.textTheme.titleLarge
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            actions: [
              Visibility(
                visible: tasksController.isMultipleSelected.isTrue,
                child: IconButton(onPressed: (){
                  tasksController.archiveTasks();
                }, icon: const Icon(IconsaxPlusLinear.trash)),
              )
            ],
            ),
        body: DefaultTabController(
            length: 2,
            child: NestedScrollView(
              physics: const NeverScrollableScrollPhysics(),
              headerSliverBuilder: (context, innerBoxIsScrolled) {
                return [
                  SliverOverlapAbsorber(
                    handle: NestedScrollView.sliverOverlapAbsorberHandleFor(
                        context),
                    sliver: SliverPersistentHeader(
                        delegate: MyDelegate(
                          TabBar(
                              tabAlignment: TabAlignment.start,
                              controller: tabController,
                              isScrollable: true,
                              dividerColor: Colors.transparent,
                              overlayColor:
                                  WidgetStateProperty.resolveWith<Color?>(
                                      (Set<WidgetState> states) {
                                return Colors.transparent;
                              }),
                              tabs: [
                                Tab(
                                    key: const Key('progressTab'),
                                    text: 'progress'.tr),
                                Tab(
                                    key: const Key('completedTab'),
                                    text: 'completed'.tr)
                              ]),
                        ),
                        floating: true,
                        pinned: true),
                  )
                ];
              },
              body: TabBarView(
                controller: tabController,
                children: [
                  TaskList(isCompleted: false),
                  TaskList(isCompleted: true)
                ],
              ),
            )),
      );
    });
  }
}
