import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/bootstrap/app_bootstrap_gate.dart';
import 'core/bootstrap/app_bootstrapper.dart';
import 'core/bootstrap/app_init_provider.dart';

/// 应用入口
/// 优化启动流程：提前初始化数据库和 Hive，实现快速启动
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 提前开始初始化，避免在 UI 线程中等待
  final bootstrapper = AppBootstrapper();
  final initFuture = bootstrapper.bootstrap();

  runApp(
    ProviderScope(
      overrides: [
        // 注入预初始化的 Future，让 AppInitNotifier 直接使用
        bootstrapResultFutureProvider.overrideWithValue(initFuture),
      ],
      child: const AppBootstrapGate(),
    ),
  );
}
