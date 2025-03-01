import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/controller/goals_controller.dart';
import 'package:todo/data/entity/goal.dart';
import 'package:todo/data/repository/goal_repository.dart';

import 'goals_controller_test.mocks.dart';

@GenerateMocks([GoalRepository])
void main() {
  /*
    Comments -
    Mock GoalRepository
  */
  
  late MockGoalRepository goalRepository;
  late GoalsController goalsController;
  
  // (Set Up) : Initialize mockGoalRepository
  setUp(() {
    goalRepository = MockGoalRepository();
    goalsController = GoalsController(repo: goalRepository);
  });

  // (Test - Display Goals) : Test fetchGoals method of GoalsController
  test('Display Goals', () {
    var goals = [
      Goal(goalId: 1,goalName: 'Finish Flutter Project 1', allTasksCount: 1, completedTasksCount: 1),
      Goal(goalId: 2, goalName: 'Finish Flutter Project 2', allTasksCount: 1, completedTasksCount: 1)
    ];
    when(goalRepository.loadAllGoals()).thenAnswer((_) async => goals);
    goalsController.fetchGoals();
    verify(goalRepository.loadAllGoals());
  });
}