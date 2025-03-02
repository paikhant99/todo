import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/data/persistence/db_service.dart';
import 'package:todo/main.dart' as app;

import 'display_goals_test.mocks.dart';

@GenerateMocks([SQLiteDatabaseService, Database])
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockSQLiteDatabaseService mockDbService;

  setUp(() {
    // Initialize mockDbService
    mockDbService = MockSQLiteDatabaseService();
    var mockDb = MockDatabase();
    when(mockDbService.getDatabase()).thenAnswer((_) async => mockDb);
    when(mockDb.query(
      any,
      distinct: anyNamed('distinct'),
      columns: anyNamed('columns'),
      where: anyNamed('where'),
      whereArgs: anyNamed('whereArgs'),
      groupBy: anyNamed('groupBy'),
      having: anyNamed('having'),
      orderBy: anyNamed('orderBy'),
      limit: anyNamed('limit'),
      offset: anyNamed('offset'),
    )).thenAnswer((_) async => Future.value([]));
  });

  group('Display Goals Test', () {
    testWidgets('should display goals correctly', (WidgetTester tester) async {
      app.main(dbService: mockDbService);
      await tester.pumpAndSettle();

      // Navigate to the goals screen
      final goalsTabFinder = find.byKey(const Key('goalsNavTab'));
      await tester.tap(goalsTabFinder);
      await tester.pumpAndSettle();

      // Verify that the goals are displayed
      expect(find.text('In Progress'), findsOneWidget);
    });
  });
}