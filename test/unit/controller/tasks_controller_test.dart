import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/controller/tasks_controller.dart';
import 'package:todo/data/entity/task.dart';
import 'package:todo/data/repository/task_repository.dart';

import 'tasks_controller_test.mocks.dart';

@GenerateMocks([TaskRepository])
void main() {
  /*
    Comments -
    Mock TaskRepository
  */

  late MockTaskRepository mockTaskRepository;
  late TasksController taskController;

  // (Set Up) : Initialize mockTaskRepository and taskController
  setUp(() {
    mockTaskRepository = MockTaskRepository();
    taskController = TasksController(repo: mockTaskRepository);
  });

  // (Test - Add New Pop up Task) : Test addTask method of TasksController
  test('Add New Pop up Task', (){
    var task = Task(
        taskName: 'Finish Flutter Project',
        description: 'Complete two steps first');

    when(mockTaskRepository.createTask(any)).thenAnswer((_) async => 1);

    taskController.addTask(task.taskName, task.description);

    verify(mockTaskRepository.createTask(any));
  });
}