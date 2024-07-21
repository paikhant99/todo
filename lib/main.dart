import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:todo/persistence/local_repository.dart';
import 'package:todo/viewmodels.dart';
import 'package:todo/views/all_tasks_screen.dart';
import 'package:todo/views/completed_all_tasks_screen.dart';
import 'package:todo/views/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(TodoApp(
    db: await SQLiteDatabaseImpl().open(),
  ));
}

class TodoApp extends StatefulWidget {
  Database db;

  TodoApp({super.key, required this.db});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  @override
  Widget build(BuildContext context) {
    final localRepo = LocalRepository(taskDao: TaskDao(db: widget.db));
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
              create: (_) =>
                  UncompletedTasksHomePageViewModel(localRepo: localRepo)),
          ChangeNotifierProvider(
              create: (_) =>
                  CompletedAllTasksScreenViewModel(localRepo: localRepo)),
          ChangeNotifierProvider(
              create: (_) => AllTasksScreenViewModel(localRepo: localRepo))
        ],
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => const HomeScreen(),
            '/completed_all_tasks': (context) =>
                const CompletedAllTasksScreen(),
            '/all_tasks': (context) => const AllTasksScreen()
          },
          title: 'Facerer App',
        ));
  }

  @override
  void dispose() {
    super.dispose();
    SQLiteDatabaseImpl().close(widget.db);
  }
}
