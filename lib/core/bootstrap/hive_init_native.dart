import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

Future<Box> openSettingsBox(String boxName) async {
  final appDocDir = await getApplicationSupportDirectory();
  final hivePath = '${appDocDir.path}${Platform.pathSeparator}hive_data';

  try {
    final hiveDir = Directory(hivePath);
    if (await hiveDir.exists()) {
      final lockFiles = hiveDir.listSync().where((f) => f.path.endsWith('.lock'));
      for (final lockFile in lockFiles) {
        try {
          await File(lockFile.path).delete();
        } catch (e) {
          debugPrint('Failed to delete Hive lock file: ${lockFile.path}, $e');
        }
      }
    }
  } catch (e) {
    debugPrint('Failed to cleanup Hive lock files: $e');
  }

  await Directory(hivePath).create(recursive: true);
  Hive.init(hivePath);
  return Hive.openBox(boxName);
}
