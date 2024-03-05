import 'package:flutter/material.dart';
import 'package:lat_permission_handler/permission_on_boarding_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const PermissionOnBoardingScreen(),
    );
  }
}
