import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/goal.dart';
import '../repositories/goals_repository.dart';

// Repository Provider
final goalsRepositoryProvider = Provider<GoalsRepository>((ref) {
  return MockGoalsRepository();
});

// Goals Notifier
class GoalsNotifier extends AsyncNotifier<List<Goal>> {
  @override
  Future<List<Goal>> build() async {
    return ref.watch(goalsRepositoryProvider).getGoals();
  }

  Future<void> addGoal(String title) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(goalsRepositoryProvider).addGoal(title);
      return ref.read(goalsRepositoryProvider).getGoals();
    });
  }

  Future<void> toggleGoal(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(goalsRepositoryProvider).toggleGoal(id);
      return ref.read(goalsRepositoryProvider).getGoals();
    });
  }

  Future<void> deleteGoal(String id) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await ref.read(goalsRepositoryProvider).deleteGoal(id);
      return ref.read(goalsRepositoryProvider).getGoals();
    });
  }
}

final goalsProvider = AsyncNotifierProvider<GoalsNotifier, List<Goal>>(() {
  return GoalsNotifier();
});

class FocusModeNotifier extends Notifier<bool> {
  @override
  bool build() => false;

  void toggle() => state = !state;
  set value(bool val) => state = val;
}

final focusModeProvider = NotifierProvider<FocusModeNotifier, bool>(FocusModeNotifier.new);

// Mock Stats Provider
final statsProvider = Provider<Map<String, String>>((ref) {
  return {
    'streak': '12 days',
    'focus_time': '42h 15m',
    'goals_completed': '128',
    'time_protected': '15h 30m',
  };
});
