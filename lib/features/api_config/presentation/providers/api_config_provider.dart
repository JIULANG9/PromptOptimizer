import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/crypto/aes_crypto_service.dart';
import '../../../../database/app_database.dart';
import '../../../../database/daos/api_config_dao.dart';
import '../../data/api_config_repository.dart';
import '../../domain/entities/api_config_entity.dart';
import '../../domain/usecases/api_config_usecases.dart';

/// API 配置列表状态
class ApiConfigListState {
  final List<ApiConfigEntity> configs;
  final bool isLoading;
  final String? errorMessage;

  const ApiConfigListState({
    this.configs = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  ApiConfigListState copyWith({
    List<ApiConfigEntity>? configs,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ApiConfigListState(
      configs: configs ?? this.configs,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

/// API 配置列表 Notifier（MVI 中的 Intent 处理器）
class ApiConfigListNotifier extends StateNotifier<ApiConfigListState> {
  final ApiConfigUseCases _useCases;

  ApiConfigListNotifier(this._useCases) : super(const ApiConfigListState()) {
    loadConfigs();
  }

  /// Intent: 加载所有配置
  Future<void> loadConfigs() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final configs = await _useCases.getAll();
      // 按 createdAt 倒序排列（最新的排在前面）
      configs.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      state = state.copyWith(configs: configs, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  /// Intent: 删除配置
  Future<void> deleteConfig(String id) async {
    try {
      await _useCases.delete(id);
      await loadConfigs();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  /// Intent: 切换启用/禁用
  Future<void> toggleEnabled(String id) async {
    try {
      await _useCases.toggleEnabled(id);
      await loadConfigs();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  /// Intent: 创建新配置
  Future<void> createConfig(ApiConfigEntity entity) async {
    try {
      await _useCases.create(entity);
      await loadConfigs();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  /// Intent: 更新配置
  Future<void> updateConfig(ApiConfigEntity entity, {String? newApiKey}) async {
    try {
      await _useCases.update(entity, newApiKey: newApiKey);
      await loadConfigs();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }
}

// ─── Providers ───

/// 数据库 Provider（由 main.dart 中 ProviderScope override 注入）
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError('appDatabaseProvider must be overridden');
});

/// AES 加密服务 Provider
final aesCryptoServiceProvider = Provider<AesCryptoService>((ref) {
  return AesCryptoService();
});

/// API 配置 DAO Provider
final apiConfigDaoProvider = Provider<ApiConfigDao>((ref) {
  return ref.watch(appDatabaseProvider).apiConfigDao;
}, dependencies: [appDatabaseProvider]);

/// API 配置仓库 Provider
final apiConfigRepositoryProvider = Provider<ApiConfigRepository>((ref) {
  return ApiConfigRepository(
    ref.watch(apiConfigDaoProvider),
    ref.watch(aesCryptoServiceProvider),
  );
}, dependencies: [apiConfigDaoProvider, aesCryptoServiceProvider, appDatabaseProvider]);

/// API 配置用例 Provider
final apiConfigUseCasesProvider = Provider<ApiConfigUseCases>((ref) {
  return ApiConfigUseCases(ref.watch(apiConfigRepositoryProvider));
}, dependencies: [apiConfigRepositoryProvider]);

/// API 配置列表状态 Provider
final apiConfigListProvider =
    StateNotifierProvider<ApiConfigListNotifier, ApiConfigListState>((ref) {
      return ApiConfigListNotifier(ref.watch(apiConfigUseCasesProvider));
    }, dependencies: [apiConfigUseCasesProvider]);
