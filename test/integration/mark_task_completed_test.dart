import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:todo/controller/tasks_controller.dart';
import 'package:todo/data/data_constants.dart';
import 'package:todo/data/persistence/db_service.dart';
import 'package:todo/data/persistence/task_dao.dart';
import 'package:todo/data/repository/task_repository.dart';

import 'package:todo/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  late SQLiteDatabaseService dbService;
  late Database db;

  // (Set Up All - Event) : Set up all initialization for integration testing
  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    dbService = SQLiteDatabaseService();
    db = await dbService.getDatabase();
    await db.insert(tasksTableName, {
      taskName: "Open Database",
      taskDesc: "Database Opened",
      createdAt: dbService.getCurrentTimestamp(),
      modifiedAt: dbService.getCurrentTimestamp()
    });
    Get.put(TaskDao(databaseService: dbService));
    Get.put(TaskRepository(taskDao: Get.find()));
    Get.put(TasksController(repo: Get.find()));
  });

  // (Tear Down All - Event) : Tear down / dispose all initializations defined by setUpAll method
  tearDownAll(() async {
    await db.delete(tasksTableName);
    dbService.close();
    Get.reset();
  });

  testWidgets('Mark Task Completed', (WidgetTester tester) async {
    // The user launches the app
    app.main();

    // The app loads the task list on the screen.
    await tester.pumpAndSettle(const Duration(seconds: 5));

    // The user ticks a radio box of the task item card.
    final completedCheckbox = find.byKey(const Key('completedCheckbox_0'));
    await tester.tap(completedCheckbox);

    // The task item card disappears from the screen.
    await tester.pumpAndSettle();

    // The user taps the 'accomplished' tab.
    final completedTab = find.byKey(const Key('completedTab'));
    await tester.tap(completedTab);

    // The task item card selected appears on the screen.
    await tester.pumpAndSettle();

    expect(find.text('Open Database'), findsOne);
  });
}
