import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:todo/data/entity/task.dart';
import 'package:todo/data/repository/task_repository.dart';
import 'package:todo/data/persistence/task_dao.dart';

import 'task_repository_test.mocks.dart';

@GenerateMocks([TaskDao])
void main() {
  /*
    Comments -
    Mock TaskDao
  */

  late MockTaskDao mockTaskDao;
  late TaskRepository taskRepository;

  // (Set Up) : Initialize mockTaskDao and taskRepository
  setUp((){
    mockTaskDao = MockTaskDao();
    taskRepository = TaskRepository(taskDao: mockTaskDao);
  });

  // (Test - Add New Pop up Task) : Test createTask method of taskRepository
  test('Add New Pop up Task', ()async{
    var task = Task(
        taskId: 1,
        taskName: 'Finish Flutter Project',
        description: 'Complete two steps first');

    when(mockTaskDao.create(task)).thenAnswer((_) async => task.taskId!);
        
    var taskReturnId = await taskRepository.createTask(task);

    expect(taskReturnId, task.taskId);
  });

}