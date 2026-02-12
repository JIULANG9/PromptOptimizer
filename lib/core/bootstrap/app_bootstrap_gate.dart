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
        return const MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Center(
              child: Text('Loading...'),
            ),
          ),
        );
      case AppInitStatus.error:
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Failed to initialize'),
                  const SizedBox(height: 12),
                  Text(initState.errorMessage ?? 'Unknown error'),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () => ref.read(appInitProvider.notifier).start(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
        );
      case AppInitStatus.ready:
        final result = initState.result;
        if (result == null) {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              body: Center(
                child: Text('Loading...'),
              ),
            ),
          );
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
