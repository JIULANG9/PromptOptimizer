import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
 
import 'core/bootstrap/app_bootstrap_gate.dart';

/// 应用入口
/// 初始化顺序: Hive → Database → 默认模板 → ProviderScope → App
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    const ProviderScope(
      child: AppBootstrapGate(),
    ),
  );
}
