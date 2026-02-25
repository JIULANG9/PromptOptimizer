import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../ai_app_launcher/presentation/providers/ai_app_provider.dart';
import '../../../ai_app_launcher/presentation/widgets/animated_ai_app_button.dart';
import '../../../widgets/glass/glass_widgets.dart';

/// AI 应用启动器区域
/// 显示已启用的 AI 应用按钮，支持一键跳转，可折叠
class AIAppLauncherSection extends ConsumerStatefulWidget {
  final String promptText;

  const AIAppLauncherSection({super.key, required this.promptText});

  @override
  ConsumerState<AIAppLauncherSection> createState() =>
      _AIAppLauncherSectionState();
}

class _AIAppLauncherSectionState extends ConsumerState<AIAppLauncherSection>
    with SingleTickerProviderStateMixin {
  late Box _stateBox;
  bool _isCollapsed = false;
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _stateBox = Hive.box(AppConstants.aiAppLauncherBoxName);
    _isCollapsed =
        _stateBox.get(AppConstants.aiAppLauncherCollapsedKey, defaultValue: false) as bool;

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 0.5,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    if (_isCollapsed) {
      _animationController.value = 1.0;
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleCollapse() {
    setState(() {
      _isCollapsed = !_isCollapsed;
      _stateBox.put(AppConstants.aiAppLauncherCollapsedKey, _isCollapsed);

      if (_isCollapsed) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final appsAsync = ref.watch(enabledAIAppListProvider);

    return appsAsync.when(
      data: (apps) {
        if (apps.isEmpty) return const SizedBox.shrink();

        return GlassCard(
          margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          borderRadius: BorderRadius.circular(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              InkWell(
                onTap: _toggleCollapse,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      Text(
                        l10n.quickLaunchTitle,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const Spacer(),
                      RotationTransition(
                        turns: _rotationAnimation,
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          size: 20,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                child: _isCollapsed
                    ? const SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: WrapAlignment.start,
                          children: List.generate(
                            apps.length,
                            (index) {
                              final app = apps[index];
                              return AnimatedAIAppButton(
                                app: app,
                                mode: AnimationMode.multiple,
                                index: index,
                                onTap: () {
                                  ref
                                      .read(aIAppManagerProvider.notifier)
                                      .launchApp(app.id, widget.promptText);
                                },
                              );
                            },
                          ),
                        ),
                      ),
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (error, stackTrace) => const SizedBox.shrink(),
    );
  }
}
