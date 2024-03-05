import 'package:app_settings/app_settings.dart';

Future<void> openAppSettings() async {
  await AppSettings.openAppSettings(type: AppSettingsType.settings);
}
