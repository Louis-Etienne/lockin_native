class TaskBasket{
  final List<Task> tasks;

  const TaskBasket({
    required this.tasks
  });
}

class Task{
  final String id;
  final String name;
  final bool isCompleted;

  Task copyWith({
    String? id,
    String? name,
    bool? isCompleted
  }){
    return Task(
      id: id ?? this.id,
      name: name ?? this.name,
      isCompleted: isCompleted ?? this.isCompleted
    );
  }

  const Task({
    required this.id,
    required this.name,
    required this.isCompleted
  });
}