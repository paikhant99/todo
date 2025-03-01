import 'package:get/get.dart';
import 'package:todo/data/entity/goal.dart';
import 'package:todo/data/repository/goal_repository.dart';

class GoalsController extends GetxController{
  /*
   comment -
  */

  final GoalRepository repo;
  final goals = <Goal>[].obs;

  GoalsController({required this.repo});
  
  void fetchGoals() {
    repo.loadAllGoals().then((goalValues) {
      goals.assignAll(goalValues);
    });
  }
}