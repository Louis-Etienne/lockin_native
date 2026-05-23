import 'package:lockin_native_2/domain/lock_in.dart';

class LockInDto {
  final bool isLockedIn;

  LockInDto.fromJson(Map<String, dynamic> json) : 
    isLockedIn = json["is_focus"];

  LockIn toDomain(){
    return LockIn(isLockedIn: isLockedIn);
  }
}