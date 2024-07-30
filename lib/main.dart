import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/constants.dart';
import 'package:todo/persistence/local_repository.dart';
import 'package:todo/all_tasks_viewmodel.dart';
import 'package:todo/views/completed_all_tasks_screen.dart';
import 'package:todo/views/home_screen.dart';

void main() async {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider<SQLiteDatabaseService>(
            create: (_) => SQLiteDatabaseService()..open(),
            dispose: (_, dbService) => dbService.close(),
          ),
          ProxyProvider<SQLiteDatabaseService, TaskDao>(
            update: (_, dbService, __) => TaskDao(databaseService: dbService),
          ),
          ProxyProvider<TaskDao, LocalRepository>(
            update: (_, taskDao, __) => LocalRepository(taskDao: taskDao),
          ),
          ChangeNotifierProxyProvider(
              create: (context) => AllTasksViewModel(
                  localRepo:
                      Provider.of<LocalRepository>(context, listen: false)),
              update: (_, localRep, allTasksViewModel) => allTasksViewModel!),
        ],
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => const HomeScreen(),
            '/completed_all_tasks': (context) =>
                const CompletedAllTasksScreen(),
          },
          title: APP_TITLE,
        ));
  }
}
