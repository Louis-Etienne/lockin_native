import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lockin_native_2/domain/lock_in.dart';
import 'package:lockin_native_2/repositories/lock_in_repository.dart';

final lockInRepositoryProvider = Provider<LockInRepository>((ref){
  return MockLockInRepository();
});

class LockInNotifier extends AsyncNotifier<LockIn>{
  @override
  Future<LockIn> build() async{
    return ref.read(lockInRepositoryProvider).get();
  }

  Future<void> lockIn() async{
    state = AsyncLoading();

    state = await AsyncValue.guard(() async{
      return ref.read(lockInRepositoryProvider).lockIn();
    });
  }

  Future<void> delockIn() async {
    state = AsyncLoading();

    state = await AsyncValue.guard(() async{
      return ref.read(lockInRepositoryProvider).delockIn();
    });
  }
}

final lockInProvider = AsyncNotifierProvider<LockInNotifier, LockIn>(LockInNotifier.new);

