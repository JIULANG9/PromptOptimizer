import 'dart:convert';

import 'package:drift/drift.dart';

import '../../../database/app_database.dart';
import '../../../database/daos/api_config_dao.dart';
import '../../../database/daos/history_dao.dart';
import '../../../database/daos/template_dao.dart';
import '../domain/entities/export_data.dart';
import 'settings_repository.dart';

/// 数据传输仓库 — 封装导入导出的数据库操作
/// 职责：从 3 个 DAO + Hive 读取/写入数据，组装/解析 JSON
class DataTransferRepository {
  final ApiConfigDao _apiConfigDao;
  final TemplateDao _templateDao;
  final HistoryDao _historyDao;
  final SettingsRepository _settingsRepo;

  DataTransferRepository(
    this._apiConfigDao,
    this._templateDao,
    this._historyDao,
    this._settingsRepo,
  );

  /// 构建导出数据
  Future<ExportData> buildExportData() async {
    // 1. 读取所有 API 配置（apiKey 保持加密态）
    final apiConfigs = await _apiConfigDao.getAllApiConfigs();
    final apiConfigMaps = apiConfigs
        .map(
          (c) => <String, dynamic>{
            'id': c.id,
            'name': c.name,
            'apiKey': c.apiKey,
            'baseUrl': c.baseUrl,
            'modelId': c.modelId,
            'isEnabled': c.isEnabled,
            'createdAt': c.createdAt,
          },
        )
        .toList();

    // 2. 读取所有模板
    final templates = await _templateDao.getAllTemplates();
    final templateMaps = templates
        .map(
          (t) => <String, dynamic>{
            'id': t.id,
            'name': t.name,
            'content': t.content,
            'templateType': t.templateType,
            'description': t.description,
            'author': t.author,
            'version': t.version,
            'isBuiltin': t.isBuiltin,
            'lastModified': t.lastModified,
            'createdAt': t.createdAt,
          },
        )
        .toList();

    // 3. 读取所有历史记录
    final histories = await _historyDao.getAllHistories();
    final historyMaps = histories
        .map(
          (h) => <String, dynamic>{
            'id': h.id,
            'originalPrompt': h.originalPrompt,
            'optimizedPrompt': h.optimizedPrompt,
            'type': h.type,
            'modelKey': h.modelKey,
            'templateId': h.templateId,
            'timestamp': h.timestamp,
            'metadata': h.metadata,
          },
        )
        .toList();

    // 4. 读取选中状态
    final settings = <String, String?>{
      'selectedApiConfigId': _settingsRepo.getSelectedApiConfigId(),
      'selectedUserTemplateId': _settingsRepo.getSelectedTemplateId(
        'userOptimize',
      ),
      'selectedSystemTemplateId': _settingsRepo.getSelectedTemplateId(
        'systemOptimize',
      ),
    };

    return ExportData(
      exportedAt: DateTime.now().millisecondsSinceEpoch,
      apiConfigs: apiConfigMaps,
      templates: templateMaps,
      histories: historyMaps,
      settings: settings,
    );
  }

  /// 将导出数据序列化为 JSON 字符串
  Future<String> exportToJson() async {
    final data = await buildExportData();
    const encoder = JsonEncoder.withIndent('  ');
    return encoder.convert(data.toJson());
  }

  /// 从 JSON 字符串解析并导入数据
  /// 策略：同 ID 覆盖，新 ID 追加
  Future<void> importFromJson(String jsonString) async {
    final Map<String, dynamic> jsonMap =
        jsonDecode(jsonString) as Map<String, dynamic>;
    final exportData = ExportData.fromJson(jsonMap);

    // 1. 导入 API 配置
    for (final configMap in exportData.apiConfigs) {
      final id = configMap['id'] as String;
      final existing = await _apiConfigDao.getApiConfigById(id);

      if (existing != null) {
        await _apiConfigDao.updateApiConfig(
          ApiConfigsCompanion(
            id: Value(id),
            name: Value(configMap['name'] as String),
            apiKey: Value(configMap['apiKey'] as String),
            baseUrl: Value(configMap['baseUrl'] as String),
            modelId: Value(configMap['modelId'] as String),
            isEnabled: Value(configMap['isEnabled'] as bool? ?? true),
            createdAt: Value(
              configMap['createdAt'] as int? ??
                  DateTime.now().millisecondsSinceEpoch,
            ),
          ),
        );
      } else {
        await _apiConfigDao.insertApiConfig(
          ApiConfigsCompanion.insert(
            id: id,
            name: configMap['name'] as String,
            apiKey: configMap['apiKey'] as String,
            baseUrl: Value(configMap['baseUrl'] as String),
            modelId: Value(configMap['modelId'] as String),
            isEnabled: Value(configMap['isEnabled'] as bool? ?? true),
          ),
        );
      }
    }

    // 2. 导入模板
    for (final tplMap in exportData.templates) {
      final id = tplMap['id'] as String;
      final existing = await _templateDao.getTemplateById(id);

      if (existing != null) {
        await _templateDao.updateTemplate(
          PromptTemplatesCompanion(
            id: Value(id),
            name: Value(tplMap['name'] as String),
            content: Value(tplMap['content'] as String),
            templateType: Value(tplMap['templateType'] as String),
            description: Value(tplMap['description'] as String? ?? ''),
            author: Value(tplMap['author'] as String? ?? 'User'),
            version: Value(tplMap['version'] as String? ?? '1.0.0'),
            lastModified: Value(tplMap['lastModified'] as int),
          ),
        );
      } else {
        await _templateDao.insertTemplate(
          PromptTemplatesCompanion.insert(
            id: id,
            name: tplMap['name'] as String,
            content: tplMap['content'] as String,
            templateType: tplMap['templateType'] as String,
            description: Value(tplMap['description'] as String? ?? ''),
            author: Value(tplMap['author'] as String? ?? 'User'),
            version: Value(tplMap['version'] as String? ?? '1.0.0'),
            isBuiltin: Value(tplMap['isBuiltin'] as bool? ?? false),
            lastModified: tplMap['lastModified'] as int,
            createdAt: tplMap['createdAt'] as int,
          ),
        );
      }
    }

    // 3. 导入历史记录
    for (final histMap in exportData.histories) {
      final id = histMap['id'] as String;
      final existing = await _historyDao.getHistoryById(id);

      if (existing != null) {
        await _historyDao.updateHistory(
          OptimizationHistoriesCompanion(
            id: Value(id),
            originalPrompt: Value(histMap['originalPrompt'] as String),
            optimizedPrompt: Value(histMap['optimizedPrompt'] as String),
            type: Value(histMap['type'] as String),
            modelKey: Value(histMap['modelKey'] as String),
            templateId: Value(histMap['templateId'] as String),
            timestamp: Value(histMap['timestamp'] as int),
            metadata: Value(histMap['metadata'] as String? ?? '{}'),
          ),
        );
      } else {
        await _historyDao.insertHistory(
          OptimizationHistoriesCompanion.insert(
            id: id,
            originalPrompt: histMap['originalPrompt'] as String,
            optimizedPrompt: histMap['optimizedPrompt'] as String,
            type: histMap['type'] as String,
            modelKey: histMap['modelKey'] as String,
            templateId: histMap['templateId'] as String,
            timestamp: histMap['timestamp'] as int,
            metadata: Value(histMap['metadata'] as String? ?? '{}'),
          ),
        );
      }
    }

    // 4. 导入选中状态
    final settings = exportData.settings;
    if (settings.containsKey('selectedApiConfigId')) {
      await _settingsRepo.saveSelectedApiConfigId(
        settings['selectedApiConfigId'],
      );
    }
    if (settings.containsKey('selectedUserTemplateId')) {
      await _settingsRepo.saveSelectedTemplateId(
        'userOptimize',
        settings['selectedUserTemplateId'],
      );
    }
    if (settings.containsKey('selectedSystemTemplateId')) {
      await _settingsRepo.saveSelectedTemplateId(
        'systemOptimize',
        settings['selectedSystemTemplateId'],
      );
    }
  }
}
