import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/data/data_constants.dart';
import 'package:todo/data/entity/goal.dart';
import 'package:todo/data/persistence/goal_dao.dart';
import 'package:todo/data/repository/goal_repository.dart';

import 'goal_repository_test.mocks.dart';

@GenerateMocks([GoalDao])
void main() {
  /*
    Comments -
    Mock GoalDao
  */

  late MockGoalDao mockGoalDao;
  late GoalRepository goalRepository;

  // (Set Up) : Initialize mockGoalDao and goalRepository
  setUp(() {
    mockGoalDao = MockGoalDao();
    goalRepository = GoalRepository(goalDao: mockGoalDao);
  });

  // (Test - Display Goals) : Test loadAllGoals method of goalRepository
  test('Display Goals', () async {
    var goals = [
      Goal(goalId: 1,goalName: 'Finish Flutter Project 1', allTasksCount: 1, completedTasksCount: 1),
      Goal(goalId: 2, goalName: 'Finish Flutter Project 2', allTasksCount: 1, completedTasksCount: 1)
    ];

    when(mockGoalDao.readAllGoals()).thenAnswer((_) async => goals);

    var goalsReturn = await goalRepository.loadAllGoals();

    expect(goalsReturn.length, goals.length);
  });
}