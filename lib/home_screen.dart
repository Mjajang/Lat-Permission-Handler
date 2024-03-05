import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:lat_permission_handler/data/datasources/upload_photo.dart';
import 'package:lat_permission_handler/platform/device_info.dart';
import 'package:lat_permission_handler/platform/permission_info.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PermissionInfo _permissionInfo = PermissionInfoImpl(
    deviceInfo: DeviceInfoImpl(
      plugin: DeviceInfoPlugin(),
    ),
  );

  late final UploadPhotoImpl _uploadPhotoImpl;

  @override
  void initState() {
    super.initState();
    _uploadPhotoImpl = UploadPhotoImpl(permissionInfo: _permissionInfo);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Hello world'),
            const SizedBox(height: 10),
            IconButton.filled(
              onPressed: () async => _uploadPhotoImpl.uploadPhoto(context),
              icon: const Icon(Icons.upload),
            ),
          ],
        ),
      ),
    );
  }
}
