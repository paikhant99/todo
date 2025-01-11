import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:todo/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('Add New Pop Up Task', (WidgetTester tester) async {
    // The user launches the app.
    app.main();

    await tester.pumpAndSettle();

    // The user taps FAB on the home screen.
    final addFAB = find.byKey(const Key('addFAB'));
    await tester.tap(addFAB);

    // The app pops up the task action screen from the bottom.
    await tester.pumpAndSettle();

    // The user fills in the task name and description box.
    final taskNameInput = find.byKey(const Key('taskNameInput'));
    await tester.enterText(taskNameInput, 'Finish Up2Task App');

    final taskDescInput = find.byKey(const Key('taskDescriptionInput'));
    await tester.enterText(
        taskDescInput, 'Note: You can resolve the problem easily.');

    // The user taps the done button.
    final taskDoneButton = find.byKey(const Key('doneButton'));
    await tester.tap(taskDoneButton);

    // The app saves the written.
    // The task action screen disappears to the bottom.
    await tester.pumpAndSettle();

    // The saved task appears on the task list of the backlog.
    expect(find.text('Finish Up2Task App'), findsOneWidget);
  });
}
