import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../database/daos/template_dao.dart';
import '../../../api_config/presentation/providers/api_config_provider.dart';
import '../../data/template_repository.dart';
import '../../domain/entities/template_entity.dart';
import '../../domain/usecases/template_usecases.dart';

/// 模板列表状态
class TemplateListState {
  final List<TemplateEntity> templates;
  final bool isLoading;
  final String filterType; // 'all' | 'userOptimize' | 'systemOptimize'
  final String? errorMessage;

  const TemplateListState({
    this.templates = const [],
    this.isLoading = false,
    this.filterType = 'all',
    this.errorMessage,
  });

  TemplateListState copyWith({
    List<TemplateEntity>? templates,
    bool? isLoading,
    String? filterType,
    String? errorMessage,
    bool clearError = false,
  }) {
    return TemplateListState(
      templates: templates ?? this.templates,
      isLoading: isLoading ?? this.isLoading,
      filterType: filterType ?? this.filterType,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

/// 模板列表 Notifier（MVI Intent 处理器）
class TemplateListNotifier extends StateNotifier<TemplateListState> {
  final TemplateUseCases _useCases;

  TemplateListNotifier(this._useCases) : super(const TemplateListState()) {
    loadTemplates();
  }

  /// Intent: 加载所有模板
  Future<void> loadTemplates() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final templates = state.filterType == 'all'
          ? await _useCases.getAll()
          : await _useCases.getByType(state.filterType);
      // 按 lastModified 倒序排列（最新的排在前面）
      templates.sort((a, b) => b.lastModified.compareTo(a.lastModified));
      state = state.copyWith(templates: templates, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  /// Intent: 按类型筛选
  Future<void> filterByType(String type) async {
    state = state.copyWith(filterType: type);
    await loadTemplates();
  }

  /// Intent: 删除模板
  Future<void> deleteTemplate(String id) async {
    try {
      await _useCases.delete(id);
      await loadTemplates();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  /// Intent: 创建模板
  Future<void> createTemplate(TemplateEntity entity) async {
    try {
      await _useCases.create(entity);
      await loadTemplates();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  /// Intent: 更新模板
  Future<void> updateTemplate(TemplateEntity entity) async {
    try {
      await _useCases.update(entity);
      await loadTemplates();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }
}

// ─── Providers ───

/// 模板 DAO Provider
final templateDaoProvider = Provider<TemplateDao>((ref) {
  return ref.watch(appDatabaseProvider).templateDao;
}, dependencies: [appDatabaseProvider]);

/// 模板仓库 Provider
final templateRepositoryProvider = Provider<TemplateRepository>((ref) {
  return TemplateRepository(ref.watch(templateDaoProvider));
}, dependencies: [templateDaoProvider, appDatabaseProvider]);

/// 模板用例 Provider
final templateUseCasesProvider = Provider<TemplateUseCases>((ref) {
  return TemplateUseCases(ref.watch(templateRepositoryProvider));
}, dependencies: [templateRepositoryProvider]);

/// 模板列表状态 Provider
final templateListProvider =
    StateNotifierProvider<TemplateListNotifier, TemplateListState>((ref) {
      return TemplateListNotifier(ref.watch(templateUseCasesProvider));
    }, dependencies: [templateUseCasesProvider]);
