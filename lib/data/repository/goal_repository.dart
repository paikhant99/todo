import 'package:todo/data/entity/goal.dart';
import 'package:todo/data/persistence/goal_dao.dart';

class GoalRepository {
  final GoalDao goalDao;

  GoalRepository({required this.goalDao});

  Future<List<Goal>> loadAllGoals() {
    return goalDao.readAllGoals();
  }
}