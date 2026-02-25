import 'package:hive_flutter/hive_flutter.dart';

import '../../core/constants/app_constants.dart';
import '../../database/app_database.dart';
import '../../database/seed/database_seeder.dart';
import 'hive_init.dart';

class AppBootstrapResult {
  final Box settingsBox;
  final Box aiAppLauncherBox;
  final AppDatabase database;

  const AppBootstrapResult({
    required this.settingsBox,
    required this.aiAppLauncherBox,
    required this.database,
  });
}

class AppBootstrapper {
  Future<AppBootstrapResult> bootstrap() async {
    final settingsBox = await openSettingsBox(AppConstants.settingsBoxName);
    final aiAppLauncherBox = await openSettingsBox(AppConstants.aiAppLauncherBoxName);

    final database = AppDatabase();

    final seeder = DatabaseSeeder(database.templateDao, database.apiConfigDao);
    await seeder.seedAll();

    return AppBootstrapResult(
      settingsBox: settingsBox,
      aiAppLauncherBox: aiAppLauncherBox,
      database: database,
    );
  }
}
