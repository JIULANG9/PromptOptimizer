import '../../../../core/constants/app_constants.dart';
import '../../../../database/app_database.dart';

/// 优化历史记录领域实体
class HistoryEntity {
  final String id;
  final String originalPrompt;
  final String optimizedPrompt;
  final String type; // 'userOptimize' | 'systemOptimize'
  final String modelKey; // 关联 api_config.id
  final String templateId; // 关联 template.id
  final int timestamp;
  final String metadata; // JSON 扩展字段

  const HistoryEntity({
    required this.id,
    required this.originalPrompt,
    required this.optimizedPrompt,
    required this.type,
    required this.modelKey,
    required this.templateId,
    required this.timestamp,
    this.metadata = '{}',
  });

  /// 从 Drift 数据类构造
  factory HistoryEntity.fromDrift(OptimizationHistory history) {
    return HistoryEntity(
      id: history.id,
      originalPrompt: history.originalPrompt,
      optimizedPrompt: history.optimizedPrompt,
      type: history.type,
      modelKey: history.modelKey,
      templateId: history.templateId,
      timestamp: history.timestamp,
      metadata: history.metadata,
    );
  }

  /// 原始提示词摘要（列表展示用）
  String get promptSummary {
    if (originalPrompt.length <= AppConstants.promptSummaryMaxLength) {
      return originalPrompt;
    }
    return '${originalPrompt.substring(0, AppConstants.promptSummaryMaxLength)}...';
  }

  /// 时间戳转 DateTime
  DateTime get dateTime => DateTime.fromMillisecondsSinceEpoch(timestamp);

  /// 格式化时间显示
  String get formattedTime {
    final dt = dateTime;
    return '${dt.year}-${_pad(dt.month)}-${_pad(dt.day)} '
        '${_pad(dt.hour)}:${_pad(dt.minute)}';
  }

  /// 创建副本并覆盖指定字段
  HistoryEntity copyWith({
    String? id,
    String? originalPrompt,
    String? optimizedPrompt,
    String? type,
    String? modelKey,
    String? templateId,
    int? timestamp,
    String? metadata,
  }) {
    return HistoryEntity(
      id: id ?? this.id,
      originalPrompt: originalPrompt ?? this.originalPrompt,
      optimizedPrompt: optimizedPrompt ?? this.optimizedPrompt,
      type: type ?? this.type,
      modelKey: modelKey ?? this.modelKey,
      templateId: templateId ?? this.templateId,
      timestamp: timestamp ?? this.timestamp,
      metadata: metadata ?? this.metadata,
    );
  }

  static String _pad(int value) => value.toString().padLeft(2, '0');
}
