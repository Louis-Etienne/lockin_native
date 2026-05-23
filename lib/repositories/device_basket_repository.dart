
import 'package:lockin_native_2/domain/device_basket.dart';

abstract class DeviceBasketRepository{
  Future<DeviceBasket> get();
  Future<DeviceBasket> add(Device newDevice);
  Future<DeviceBasket> remove(Device device);
  Future<DeviceBasket> activateLockIn(Device device);
  Future<DeviceBasket> deactivateLockIn(Device device);
}

class MockDeviceBasketRepository extends DeviceBasketRepository{
  final List<Device> devices = [
    ApplePhoneDevice(
      id: "id1", 
      name: "Louis' Ipad", 
      isOnline: true,
      isLockInActivated: true
    ),

    ComputerDevice(
      id: "id2", 
      name: "Framework 13 - New edition", 
      isOnline: false,
      isLockInActivated: false
    ),

    AndroidPhoneDevice(
      id: "id3",
      name: "Android phone A13",
      isOnline: true,
      isLockInActivated: false
    )
  ];

  @override
  Future<DeviceBasket> add(Device newDevice) async{
    devices.add(newDevice);

    await Future.delayed(Duration(milliseconds: 500));

    return DeviceBasket(devices: devices);
  }

  @override
  Future<DeviceBasket> remove(Device device) async{
    devices.removeWhere((d)=> d.id == device.id);

    await Future.delayed(Duration(milliseconds: 500));

    return DeviceBasket(devices: devices);
  }

  @override
  Future<DeviceBasket> activateLockIn(Device device) async{
    final index = devices.indexWhere((d)=> d.id == device.id);

    final updated = devices[index].copyWith(isLockInActivated: true);

    devices[index] = updated;

    await Future.delayed(Duration(milliseconds: 400));

    return DeviceBasket(devices: devices);
  }

  @override
  Future<DeviceBasket> deactivateLockIn(Device device) async{
    final index = devices.indexWhere((d)=> d.id == device.id);

    final updated = devices[index].copyWith(isLockInActivated: false);

    devices[index] = updated;

    await Future.delayed(Duration(milliseconds: 500));

    return DeviceBasket(devices: devices);
  }

  @override
  Future<DeviceBasket> get() async{
    await Future.delayed(Duration(milliseconds: 500));

    return DeviceBasket(devices: devices);
  }
  
}