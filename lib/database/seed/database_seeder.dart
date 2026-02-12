import '../daos/api_config_dao.dart';
import '../daos/template_dao.dart';
import 'default_api_configs.dart';
import 'default_templates.dart';

/// 数据库种子数据初始化器
/// 负责在首次启动时插入默认数据
class DatabaseSeeder {
  final TemplateDao _templateDao;
  final ApiConfigDao _apiConfigDao;

  DatabaseSeeder(this._templateDao, this._apiConfigDao);

  /// 插入默认模板（已有数据则跳过）
  Future<void> seedDefaultTemplates() async {
    final existing = await _templateDao.getAllTemplates();
    if (existing.isNotEmpty) return;

    for (final template in DefaultTemplates.getAll()) {
      await _templateDao.insertTemplate(template);
    }
  }

  /// 插入默认 API 配置（已有数据则跳过）
  Future<void> seedDefaultApiConfigs() async {
    final existing = await _apiConfigDao.getAllApiConfigs();
    if (existing.isNotEmpty) return;

    for (final config in DefaultApiConfigs.getAll()) {
      await _apiConfigDao.insertApiConfig(config);
    }
  }

  /// 执行所有种子数据初始化
  Future<void> seedAll() async {
    await seedDefaultTemplates();
    await seedDefaultApiConfigs();
  }
}
