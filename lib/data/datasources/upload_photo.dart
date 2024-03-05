// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lat_permission_handler/platform/permission_info.dart';

import '../../platform/open_external_app.dart';

class UploadPhotoImpl {
  final PermissionInfo permissionInfo;

  UploadPhotoImpl({
    required this.permissionInfo,
  });

  Future<void> uploadPhoto(BuildContext context) async {
    if (await permissionInfo.storagePermissionIsDeniedPermanently()) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Expanded(
                child: Text(
                  'Please manually grant storage permissions from Settings.',
                ),
              ),
              SizedBox(
                height: 36,
                child: TextButton(
                  onPressed: () async {
                    await openAppSettings();
                  },
                  child: const Text(
                    'Allow',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else if (await permissionInfo.storagePermissionIsDenied()) {
      await permissionInfo.storagePermissionRequest();
    } else {
      if (!context.mounted) return;

      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: const Center(
              child: Text('Upload photos'),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
            ],
          );
        },
      );
    }
  }
}
