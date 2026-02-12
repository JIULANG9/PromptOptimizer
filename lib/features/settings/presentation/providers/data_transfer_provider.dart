import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../api_config/presentation/providers/api_config_provider.dart';
import '../../../history/presentation/providers/history_provider.dart';
import '../../../optimization/presentation/providers/optimization_provider.dart';
import '../../../template/presentation/providers/template_provider.dart';
import '../../data/data_transfer_repository.dart';
import '../../domain/usecases/data_transfer_usecases.dart';
import 'settings_provider.dart';

/// 数据传输状态
enum DataTransferStatus { idle, exporting, importing }

/// 数据传输 Repository Provider
final dataTransferRepositoryProvider = Provider<DataTransferRepository>((ref) {
  return DataTransferRepository(
    ref.watch(apiConfigDaoProvider),
    ref.watch(templateDaoProvider),
    ref.watch(historyDaoProvider),
    ref.watch(settingsRepositoryProvider),
  );
});

/// 数据传输 UseCase Provider
final dataTransferUseCasesProvider = Provider<DataTransferUseCases>((ref) {
  return DataTransferUseCases(ref.watch(dataTransferRepositoryProvider));
});

/// 数据传输状态 Notifier（MVI Intent 处理器）
/// 管理导入导出的异步状态，导入成功后刷新所有相关 Provider
class DataTransferNotifier extends StateNotifier<DataTransferStatus> {
  final DataTransferUseCases _useCases;
  final Ref _ref;

  DataTransferNotifier(this._useCases, this._ref)
    : super(DataTransferStatus.idle);

  /// Intent: 导出数据
  Future<void> exportData() async {
    state = DataTransferStatus.exporting;
    try {
      await _useCases.exportData();
      state = DataTransferStatus.idle;
    } catch (e) {
      state = DataTransferStatus.idle;
      rethrow;
    }
  }

  /// Intent: 导入数据
  /// 返回 true 表示成功导入
  Future<bool> importData() async {
    state = DataTransferStatus.importing;
    try {
      final success = await _useCases.importData();
      if (success) {
        // 刷新所有相关 Provider，确保 UI 数据同步
        _ref.invalidate(apiConfigListProvider);
        _ref.invalidate(templateListProvider);
        _ref.invalidate(historyListProvider);
        _ref.invalidate(optimizationProvider);
      }
      state = DataTransferStatus.idle;
      return success;
    } catch (e) {
      state = DataTransferStatus.idle;
      rethrow;
    }
  }
}

/// 数据传输状态 Provider
final dataTransferProvider =
    StateNotifierProvider<DataTransferNotifier, DataTransferStatus>((ref) {
      return DataTransferNotifier(ref.watch(dataTransferUseCasesProvider), ref);
    });
