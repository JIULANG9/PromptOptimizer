import 'dart:convert';

import '../../../../core/constants/app_constants.dart';
import '../../../../database/app_database.dart';

/// 模板内容项（单条 role + content）
class TemplateContentItem {
  final String role;
  final String content;

  const TemplateContentItem({required this.role, required this.content});

  factory TemplateContentItem.fromJson(Map<String, dynamic> json) {
    return TemplateContentItem(
      role: json['role'] as String? ?? '',
      content: json['content'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'role': role, 'content': content};

  /// 替换占位符后的内容
  String buildContent(String originalPrompt) {
    return content.replaceAll(AppConstants.templatePlaceholder, originalPrompt);
  }
}

/// 提示词模板领域实体
class TemplateEntity {
  final String id;
  final String name;
  final String content; // JSON 字符串: [{role, content}]
  final String templateType; // 'userOptimize' | 'systemOptimize'
  final String description;
  final String author;
  final String version;
  final bool isBuiltin;
  final int lastModified;
  final int createdAt;

  const TemplateEntity({
    required this.id,
    required this.name,
    required this.content,
    required this.templateType,
    this.description = '',
    this.author = 'User',
    this.version = '1.0.0',
    this.isBuiltin = false,
    required this.lastModified,
    required this.createdAt,
  });

  /// 从 Drift 数据类构造
  factory TemplateEntity.fromDrift(PromptTemplate template) {
    return TemplateEntity(
      id: template.id,
      name: template.name,
      content: template.content,
      templateType: template.templateType,
      description: template.description,
      author: template.author,
      version: template.version,
      isBuiltin: template.isBuiltin,
      lastModified: template.lastModified,
      createdAt: template.createdAt,
    );
  }

  /// 解析 content JSON 为内容项列表
  List<TemplateContentItem> get contentItems {
    try {
      final List<dynamic> jsonList = jsonDecode(content) as List<dynamic>;
      return jsonList
          .map((e) => TemplateContentItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      return [];
    }
  }

  /// 构建替换占位符后的 messages 数组（用于 API 调用）
  /// 返回 `List<Map<String, String>>` 格式
  List<Map<String, String>> buildMessages(String originalPrompt) {
    return contentItems.map((item) {
      return {'role': item.role, 'content': item.buildContent(originalPrompt)};
    }).toList();
  }

  /// 构建替换占位符后的 messages JSON 字符串
  String buildMessagesJson(String originalPrompt) {
    return jsonEncode(buildMessages(originalPrompt));
  }

  /// 是否为用户提示词优化类型
  bool get isUserOptimize => templateType == AppConstants.templateTypeUser;

  /// 是否为系统提示词优化类型
  bool get isSystemOptimize => templateType == AppConstants.templateTypeSystem;

  /// 创建副本并覆盖指定字段
  TemplateEntity copyWith({
    String? id,
    String? name,
    String? content,
    String? templateType,
    String? description,
    String? author,
    String? version,
    bool? isBuiltin,
    int? lastModified,
    int? createdAt,
  }) {
    return TemplateEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      content: content ?? this.content,
      templateType: templateType ?? this.templateType,
      description: description ?? this.description,
      author: author ?? this.author,
      version: version ?? this.version,
      isBuiltin: isBuiltin ?? this.isBuiltin,
      lastModified: lastModified ?? this.lastModified,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
