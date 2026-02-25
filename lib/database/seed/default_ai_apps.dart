import 'package:drift/drift.dart';
import 'package:uuid/uuid.dart';

import '../../core/constants/app_constants.dart';
import '../app_database.dart';

/// 默认 AI 应用配置种子数据
/// 从 AppConstants.builtInAIApps 生成，确保配置统一管理
List<AIAppConfigsCompanion> get defaultAIApps {
  final now = DateTime.now().millisecondsSinceEpoch;
  return AppConstants.builtInAIApps.asMap().entries.map((entry) {
    final index = entry.key;
    final app = entry.value;
    return AIAppConfigsCompanion.insert(
      id: const Uuid().v4(),
      name: app['name']!,
      scheme: app['scheme']!,
      iconPath: app['iconPath']!,
      isEnabled: const Value(true),
      position: Value(index),
      isBuiltin: const Value(true),
      createdAt: Value(now),
    );
  }).toList();
}
