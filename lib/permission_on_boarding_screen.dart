import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:lat_permission_handler/platform/device_info.dart';

import 'platform/permission_info.dart';

class PermissionOnBoardingScreen extends StatefulWidget {
  const PermissionOnBoardingScreen({super.key});

  @override
  State<PermissionOnBoardingScreen> createState() =>
      _PermissionOnBoardingScreenState();
}

class _PermissionOnBoardingScreenState
    extends State<PermissionOnBoardingScreen> {
  final PermissionInfo _permissionInfo = PermissionInfoImpl(
    deviceInfo: DeviceInfoImpl(plugin: DeviceInfoPlugin()),
  );

  @override
  void initState() {
    _permissionInfo.checkInitialPermissionStatus(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text(
              'Storage Permission for uploading or downloading files',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            ElevatedButton(
              onPressed: () async => _permissionInfo.requestPermission(context),
              child: const Text('Allow'),
            ),
          ],
        ),
      ),
    );
  }
}
