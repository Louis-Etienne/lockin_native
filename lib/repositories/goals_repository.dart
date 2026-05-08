import '../models/goal.dart';

abstract class GoalsRepository {
  Future<List<Goal>> getGoals();
  Future<void> addGoal(String title);
  Future<void> toggleGoal(String id);
  Future<void> deleteGoal(String id);
}

class MockGoalsRepository implements GoalsRepository {
  final List<Goal> _goals = [
    Goal(id: '1', title: 'Finish the Flutter UI', isCompleted: true),
    Goal(id: '2', title: 'Set up Riverpod providers'),
    Goal(id: '3', title: 'Implement Supabase connection'),
  ];

  @override
  Future<List<Goal>> getGoals() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return List.from(_goals);
  }

  @override
  Future<void> addGoal(String title) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _goals.add(Goal(id: DateTime.now().toString(), title: title));
  }

  @override
  Future<void> toggleGoal(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    final index = _goals.indexWhere((g) => g.id == id);
    if (index != -1) {
      _goals[index] = _goals[index].copyWith(isCompleted: !_goals[index].isCompleted);
    }
  }

  @override
  Future<void> deleteGoal(String id) async {
    await Future.delayed(const Duration(milliseconds: 200));
    _goals.removeWhere((g) => g.id == id);
  }
}
