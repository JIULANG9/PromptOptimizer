import 'package:drift/drift.dart';
import 'package:drift/native.dart';

// Web 平台数据库实现
class WebDatabaseConnection {
  static DatabaseConnection createConnection() {
    // Web 平台使用内存数据库
    return DatabaseConnection(NativeDatabase.memory());
  }
}
