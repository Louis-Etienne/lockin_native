import 'package:flutter/material.dart';

class DeviceBasket {
  final List<Device> devices;

  const DeviceBasket({
    required this.devices
  });
}

sealed class Device{
  final String id;
  final String name;
  final bool isOnline;
  final bool isLockInActivated;
  IconData get icon;

  Device copyWith({
    String? id,
    String? name,
    bool? isOnline,
    bool? isLockInActivated
  });

  const Device({
    required this.id,
    required this.name,
    required this.isOnline,
    required this.isLockInActivated
  });

}

class ComputerDevice extends Device{
  
  @override
  IconData get icon => Icons.computer_rounded;

  @override
  ComputerDevice copyWith({
    String? id,
    String? name,
    bool? isOnline,
    bool? isLockInActivated
  }){
    return ComputerDevice(
      id: id ?? this.id,
      name: name ?? this.name,
      isOnline: isOnline ?? this.isOnline,
      isLockInActivated: isLockInActivated ?? this.isLockInActivated 
    );
  }

  const ComputerDevice({
    required super.id,
    required super.name,
    required super.isOnline,
    required super.isLockInActivated
  });
}


class AndroidPhoneDevice extends Device{

  @override
  IconData get icon => Icons.phone_android_rounded;

  @override
  AndroidPhoneDevice copyWith({
    String? id,
    String? name,
    bool? isOnline,
    bool? isLockInActivated
  }){
    return AndroidPhoneDevice(
      id: id ?? this.id,
      name: name ?? this.name,
      isOnline: isOnline ?? this.isOnline,
      isLockInActivated: isLockInActivated ?? this.isLockInActivated 
    );
  }

  const AndroidPhoneDevice({
    required super.id,
    required super.name,
    required super.isOnline,
    required super.isLockInActivated
  });
}


class ApplePhoneDevice extends Device{

  @override
  IconData get icon => Icons.phone_iphone_rounded;

    @override
  ApplePhoneDevice copyWith({
    String? id,
    String? name,
    bool? isOnline,
    bool? isLockInActivated
  }){
    return ApplePhoneDevice(
      id: id ?? this.id,
      name: name ?? this.name,
      isOnline: isOnline ?? this.isOnline,
      isLockInActivated: isLockInActivated ?? this.isLockInActivated 
    );
  }

  const ApplePhoneDevice({
    required super.id,
    required super.name,
    required super.isOnline,
    required super.isLockInActivated
  });
}
