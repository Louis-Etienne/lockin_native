import 'dart:async';

abstract class AuthRepository {
  Stream<bool> get authStateChanges;
  Future<void> signIn(String email, String password);
  Future<void> signUp(String email, String password);
  Future<void> signOut();
  bool get isConnected;
}

class MockAuthRepository implements AuthRepository {
  final _controller = StreamController<bool>.broadcast();
  bool _isConnected = false;

  @override
  Stream<bool> get authStateChanges => _controller.stream;

  @override
  bool get isConnected => _isConnected;

  @override
  Future<void> signIn(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    _isConnected = true;
    _controller.add(true);
  }

  @override
  Future<void> signUp(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    _isConnected = true;
    _controller.add(true);
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 400));
    _isConnected = false;
    _controller.add(false);
  }
}
