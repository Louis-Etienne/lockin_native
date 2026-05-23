

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lockin_native_2/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref){
  return MockAuthRepository();
});

class AuthNotifier extends Notifier<bool> {
  @override
  bool build(){
    return ref.watch(authRepositoryProvider).isConnected;
  }

  Future<void> signIn(String email, String password) async{
    await ref.read(authRepositoryProvider).signIn(email, password);
    state = true;
  }

  Future<void> signOut() async{
    await ref.read(authRepositoryProvider).signOut();
    state = false;
  }
}

final authStateProvider = NotifierProvider<AuthNotifier, bool>(AuthNotifier.new);