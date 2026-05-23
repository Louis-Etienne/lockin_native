
import 'package:lockin_native_2/domain/lock_in.dart';

abstract class LockInRepository {
  Future<LockIn> lockIn();
  Future<LockIn> delockIn();
  Future<LockIn> get();
}

class MockLockInRepository extends LockInRepository{
  bool isLockedIn = false;
  
  @override
  Future<LockIn> delockIn() async {
    await Future.delayed(Duration(milliseconds: 200));

    isLockedIn = false;

    return LockIn(isLockedIn: isLockedIn);
  }

  @override
  Future<LockIn> lockIn() async {
    await Future.delayed(Duration(milliseconds: 200));

    isLockedIn = true;

    return LockIn(isLockedIn: isLockedIn);
  }

  @override
  Future<LockIn> get() async{
    await Future.delayed(Duration(milliseconds: 200));

    return LockIn(isLockedIn: isLockedIn);
  }
}
