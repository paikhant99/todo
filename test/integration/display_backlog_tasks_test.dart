import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:todo/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Display Backlog Tasks', (){
    testWidgets('Display Backlog Tasks In Progress', (WidgetTester tester) async{

      // The user launches the app
      app.main();

      // The app loads the home screen.
      // The app navigates the backlog screen.
      // The app shows the pop-up tasks in progress.
      await tester.pumpAndSettle();

      // The app shows the pop-up tasks in progress.
      expect(find.text('Design Prototype'), findsOneWidget);
    });

    testWidgets('Display Backlog Tasks Completed', (WidgetTester tester) async{
      // The user launches the app
      app.main();

      // The app loads the home screen.
      // The app navigates the backlog screen.
      // The app shows the pop-up tasks in progress.
      await tester.pumpAndSettle();

      // The user taps the 'accomplished' tab.
      final completedTab = find.byKey(const Key('completedTab'));
      await tester.tap(completedTab);

      // The app shows the pop up tasks completed.
      await tester.pumpAndSettle();
      expect(find.text('Design Architecture'), findsOneWidget);

      
    });
  });
}