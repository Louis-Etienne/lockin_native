import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lockin_native_2/domain/blocked.dart';
import 'package:lockin_native_2/repositories/blocked_repository.dart';

final blockedRepositoryProvider = Provider<BlockedRepository>((ref){
  return MockBlockedRepository();
});

class BlockedNotifier extends AsyncNotifier<Blocked>{
  @override
  Future<Blocked> build() async{
    return ref.read(blockedRepositoryProvider).get();
  }

  Future<void> add(BlockedRessource newBlockedRessource) async{
    state = AsyncLoading();

    state = await AsyncValue.guard(() async{
      return ref.read(blockedRepositoryProvider).add(newBlockedRessource);
    });
  }

  Future<void> remove(BlockedRessource blockedRessource) async{
    state = AsyncLoading();

    state = await AsyncValue.guard(() async{
      return ref.read(blockedRepositoryProvider).remove(blockedRessource);
    });
  }
}

final blockedProvider = AsyncNotifierProvider<BlockedNotifier, Blocked>(BlockedNotifier.new);