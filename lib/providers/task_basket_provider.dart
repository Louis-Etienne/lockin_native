
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lockin_native_2/domain/task_basket.dart';
import 'package:lockin_native_2/repositories/task_basket_repository.dart';

final taskBasketRepositoryProvider = Provider<TaskBasketRepository>((ref){
  return MockTaskBasketRepository();
});

class TaskBasketNotifier extends AsyncNotifier<TaskBasket>{
  @override
  FutureOr<TaskBasket> build() {
    return ref.read(taskBasketRepositoryProvider).get();
  }

  Future<void> updateTask(Task task) async {
    state = AsyncLoading();

    state = await AsyncValue.guard(() async{
      return ref.read(taskBasketRepositoryProvider).updateTask(task);
    });
  }

  Future<void> add(Task task) async{
    state = AsyncLoading();

    state = await AsyncValue.guard(() async{
      return ref.read(taskBasketRepositoryProvider).add(task);
    });
  }

  Future<void> remove(Task task) async{
    state = AsyncLoading();

    state = await AsyncValue.guard(() async{
      return ref.read(taskBasketRepositoryProvider).remove(task);
    });
  }
}

final taskBasketProvider = AsyncNotifierProvider<TaskBasketNotifier, TaskBasket>(TaskBasketNotifier.new);