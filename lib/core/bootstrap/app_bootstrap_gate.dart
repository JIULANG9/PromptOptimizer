import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app.dart';
import '../../features/api_config/presentation/providers/api_config_provider.dart';
import '../../features/settings/presentation/providers/settings_provider.dart';
import 'app_init_provider.dart';

class AppBootstrapGate extends ConsumerWidget {
  const AppBootstrapGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final initState = ref.watch(appInitProvider);

    switch (initState.status) {
      case AppInitStatus.idle:
      case AppInitStatus.loading:
        // 使用透明占位符，避免白屏和 loading 字样
        return const SizedBox.shrink();
      case AppInitStatus.error:
        // 错误状态静默处理，避免影响用户体验
        // 如果初始化失败，应用将保持在加载状态
        return const SizedBox.shrink();
      case AppInitStatus.ready:
        final result = initState.result;
        if (result == null) {
          return const SizedBox.shrink();
        }

        return ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(result.database),
            settingsBoxProvider.overrideWithValue(result.settingsBox),
          ],
          child: const PromptOptimizerApp(),
        );
    }
  }
}
