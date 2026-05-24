import 'package:lockin_native_2/domain/task_basket.dart';

abstract class TaskBasketRepository {
  Future<TaskBasket> get();
  Future<TaskBasket> updateTask(Task task);
  Future<TaskBasket> add(Task task);
  Future<TaskBasket> remove(Task task);
}

class MockTaskBasketRepository extends TaskBasketRepository{
  List<Task> tasks = [
    Task(
      id: "id1",
      name: "Name of task 1",
      isCompleted: false
    ),
    Task(
      id: "id2",
      name: "Name of task 2",
      isCompleted: true
    )
  ];

  @override
  Future<TaskBasket> get() async {
    await Future.delayed(Duration(milliseconds: 500));

    return TaskBasket(tasks: tasks);
  }

  @override
  Future<TaskBasket> updateTask(Task task) async{
    await Future.delayed(Duration(milliseconds: 500));

    final index = tasks.indexWhere((t)=> t.id == task.id);

    tasks[index] = task;

    return TaskBasket(tasks: tasks);
  }

  @override
  Future<TaskBasket> add(Task task) async{
    await Future.delayed(Duration(milliseconds: 300));

    tasks.add(task);

    return TaskBasket(tasks: tasks);
  }

  @override
  Future<TaskBasket> remove(Task task) async{
    await Future.delayed(Duration(milliseconds: 300));

    tasks.removeWhere((t)=> t.id == task.id);

    return  TaskBasket(tasks: tasks);
  }

}