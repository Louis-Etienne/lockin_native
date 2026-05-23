import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lockin_native_2/domain/device_basket.dart';
import 'package:lockin_native_2/repositories/device_basket_repository.dart';

final deviceBasketRepositoryProvider = Provider<DeviceBasketRepository>((ref){
  return MockDeviceBasketRepository();
});

class DeviceBasketNotifier extends AsyncNotifier<DeviceBasket>{
  @override
  Future<DeviceBasket> build() async{
    return ref.read(deviceBasketRepositoryProvider).get();
  }

  Future<void> add(Device newDevice) async{
    state = AsyncLoading();

    state = await AsyncValue.guard(() async{
      return ref.read(deviceBasketRepositoryProvider).add(newDevice);
    });
  }

  Future<void> remove(Device device) async{
    state = AsyncLoading();

    state = await AsyncValue.guard(() async{
      return ref.read(deviceBasketRepositoryProvider).remove(device);
    });
  }

  Future<void> activateLockIn(Device device) async{
    state = AsyncLoading();

    state = await AsyncValue.guard(() async{
      return ref.read(deviceBasketRepositoryProvider).activateLockIn(device);
    });
  }

    Future<void> deactivateLockIn(Device device) async{
    state = AsyncLoading();

    state = await AsyncValue.guard(() async{
      return ref.read(deviceBasketRepositoryProvider).deactivateLockIn(device);
    });
  }
}

final deviceBasketProvider = AsyncNotifierProvider<DeviceBasketNotifier, DeviceBasket>(DeviceBasketNotifier.new);