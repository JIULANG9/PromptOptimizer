import 'dart:io';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

// 桌面/移动平台数据库实现
class NativeDatabaseConnection {
  static DatabaseConnection createConnection() {
    return LazyDatabase(() async {
      final dbFolder = await getApplicationDocumentsDirectory();
      final file = File(p.join(dbFolder.path, 'prompt_optimizer.sqlite'));
      return NativeDatabase(file);
    });
  }
}
