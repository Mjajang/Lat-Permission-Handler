// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../home_screen.dart';
import 'device_info.dart';

abstract class PermissionInfo {
  Future<bool> storagePermissionIsGrandted();
  Future<bool> storagePermissionIsDenied();
  Future<bool> storagePermissionIsDeniedPermanently();
  Future<void> storagePermissionRequest();
  Future<void> checkInitialPermissionStatus(BuildContext context);
  Future<void> requestPermission(BuildContext context);
}

class PermissionInfoImpl implements PermissionInfo {
  DeviceInfo deviceInfo;

  PermissionInfoImpl({
    required this.deviceInfo,
  });

  @override
  Future<bool> storagePermissionIsDenied() async {
    final status = await Permission.storage.status;
    return status.isDenied || status.isPermanentlyDenied;
  }

  @override
  Future<bool> storagePermissionIsGrandted() async {
    final status = await Permission.storage.status;
    return status.isGranted;
  }

  @override
  Future<bool> storagePermissionIsDeniedPermanently() async {
    final status = await Permission.storage.status;
    return status.isPermanentlyDenied;
  }

  @override
  Future<void> storagePermissionRequest() async {
    final isAndroid = await deviceInfo.isAndroid();

    if (isAndroid) {
      await Permission.storage.request();
    } else if (Platform.isIOS) {
      await [Permission.storage].request();
    } else {
      PermissionStatus.granted;
    }
  }

  @override
  Future<void> checkInitialPermissionStatus(context) async {
    if (await storagePermissionIsGrandted()) {
      if (!context.mounted) return;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    }
  }

  @override
  Future<void> requestPermission(context) async {
    await storagePermissionRequest();

    if (await storagePermissionIsGrandted() ||
        await storagePermissionIsDenied()) {
      if (!context.mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );
    }
  }
}
