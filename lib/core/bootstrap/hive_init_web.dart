import 'package:hive_flutter/hive_flutter.dart';

Future<Box> openSettingsBox(String boxName) async {
  await Hive.initFlutter();
  return Hive.openBox(boxName);
}
