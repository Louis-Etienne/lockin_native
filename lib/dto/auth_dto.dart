import 'package:lockin_native_2/domain/auth.dart';

class AuthDto {
  final String userId;
  final String email;

  AuthDto.fromJson(Map<String, dynamic> json) :
    userId = json['user_id'],
    email = json['email'];

  Auth toDomain(){
    return Auth(
      userId: userId,
      email: email
    );
  }
}