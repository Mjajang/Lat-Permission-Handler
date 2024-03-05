import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

abstract class DeviceInfo {
  Future<bool> isAndroid();
}

class DeviceInfoImpl implements DeviceInfo {
  final DeviceInfoPlugin plugin;

  DeviceInfoImpl({required this.plugin});

  @override
  Future<bool> isAndroid() async {
    final androidInfo = await plugin.androidInfo;

    if (Platform.isAndroid && androidInfo.version.sdkInt < 34) {
      return true;
    }

    return false;
  }
}
