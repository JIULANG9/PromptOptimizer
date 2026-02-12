import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../database/daos/history_dao.dart';
import '../../../api_config/presentation/providers/api_config_provider.dart';
import '../../data/history_repository.dart';
import '../../domain/entities/history_entity.dart';
import '../../domain/usecases/history_usecases.dart';

/// 历史记录列表状态
class HistoryListState {
  final List<HistoryEntity> histories;
  final bool isLoading;
  final String? errorMessage;

  const HistoryListState({
    this.histories = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  HistoryListState copyWith({
    List<HistoryEntity>? histories,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return HistoryListState(
      histories: histories ?? this.histories,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}

/// 历史记录列表 Notifier（MVI Intent 处理器）
class HistoryListNotifier extends StateNotifier<HistoryListState> {
  final HistoryUseCases _useCases;

  HistoryListNotifier(this._useCases) : super(const HistoryListState()) {
    loadHistories();
  }

  /// Intent: 加载所有历史记录
  Future<void> loadHistories() async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final histories = await _useCases.getAll();
      state = state.copyWith(histories: histories, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  /// Intent: 删除单条历史
  Future<void> deleteHistory(String id) async {
    try {
      await _useCases.delete(id);
      await loadHistories();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }

  /// Intent: 清空所有历史
  Future<void> clearAll() async {
    try {
      await _useCases.deleteAll();
      await loadHistories();
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString());
    }
  }
}

// ─── Providers ───

/// 历史记录 DAO Provider
final historyDaoProvider = Provider<HistoryDao>((ref) {
  return ref.watch(appDatabaseProvider).historyDao;
}, dependencies: [appDatabaseProvider]);

/// 历史记录仓库 Provider
final historyRepositoryProvider = Provider<HistoryRepository>((ref) {
  return HistoryRepository(ref.watch(historyDaoProvider));
}, dependencies: [historyDaoProvider, appDatabaseProvider]);

/// 历史记录用例 Provider
final historyUseCasesProvider = Provider<HistoryUseCases>((ref) {
  return HistoryUseCases(ref.watch(historyRepositoryProvider));
}, dependencies: [historyRepositoryProvider]);

/// 历史记录列表状态 Provider
final historyListProvider =
    StateNotifierProvider<HistoryListNotifier, HistoryListState>((ref) {
      return HistoryListNotifier(ref.watch(historyUseCasesProvider));
    }, dependencies: [historyUseCasesProvider]);
