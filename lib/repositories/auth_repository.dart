import 'dart:async';

import 'package:lockin_native_2/domain/auth.dart';

abstract class AuthRepository {
  Future<Auth> signIn(String email, String password);
  Future<Auth> signUp(String email, String password);
  Future<Auth> signOut();
  Future<Auth> get();
}

class MockAuthRepository implements AuthRepository{

  String email = "mock@test.com";
  String? userId;

  @override
  Future<Auth> signIn(String email, String password) async{
    await Future.delayed(const Duration(milliseconds: 800));

    userId = "userId";

    return Auth(
      email: email,
      userId: userId
    );
  }

  @override
  Future<Auth> signUp(String email, String password) async{
    await Future.delayed(const Duration(milliseconds: 800));

    userId = "userId";

    return Auth(
      email: email,
      userId: userId
    );
  }

  @override
  Future<Auth> signOut() async{
    await Future.delayed(const Duration(milliseconds: 800));

    userId = null;

    return Auth(
      email: email,
      userId: userId
    );
  }

  @override
  Future<Auth> get() async{
    await Future.delayed(const Duration(milliseconds: 800));

    return Auth(
      email: email,
      userId: userId
    );
  }
}