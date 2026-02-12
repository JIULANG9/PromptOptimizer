import 'package:hive_flutter/hive_flutter.dart';

import 'hive_init_native.dart' if (dart.library.html) 'hive_init_web.dart'
    as impl;

Future<Box> openSettingsBox(String boxName) {
  return impl.openSettingsBox(boxName);
}
