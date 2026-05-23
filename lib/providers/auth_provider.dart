

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lockin_native_2/domain/auth.dart';
import 'package:lockin_native_2/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref){
  return MockAuthRepository();
});

class AuthNotifier extends AsyncNotifier<Auth>{
  @override
  Future<Auth> build() async{
    return ref.read(authRepositoryProvider).get();
  }

  Future<void> signIn(String email, String password) async {
    state = AsyncLoading();
    
    state = await AsyncValue.guard(() async {
      return ref.read(authRepositoryProvider).signIn(email, password);
    });
  }

  Future<void> signUp(String email, String password) async {
    state = AsyncLoading();
    
    state = await AsyncValue.guard(() async {
      return ref.read(authRepositoryProvider).signUp(email, password);
    });
  }

  Future<void> signOut() async{
    state = AsyncLoading();
    
    state = await AsyncValue.guard(() async {
      return ref.read(authRepositoryProvider).signOut();
    });
  }
}

final authProvider = AsyncNotifierProvider<AuthNotifier, Auth>(AuthNotifier.new);