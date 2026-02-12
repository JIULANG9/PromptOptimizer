import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../widgets/glass/glass_widgets.dart';

/// 首页顶部双 Tab 切换栏
/// 带丝滑滑动毛玻璃指示器动画
/// 用户提示词优化 / 系统提示词优化
class PromptTabBar extends StatelessWidget {
  final String currentTab;
  final ValueChanged<String> onTabChanged;

  const PromptTabBar({
    super.key,
    required this.currentTab,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isUser = currentTab == AppConstants.templateTypeUser;

    final tabs = [
      _TabData(
        label: l10n.tabUserOptimize,
        type: AppConstants.templateTypeUser,
      ),
      _TabData(
        label: l10n.tabSystemOptimize,
        type: AppConstants.templateTypeSystem,
      ),
    ];

    return GlassCard(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(4),
      borderRadius: BorderRadius.circular(25),
      blurSigma: 15,
      lightOpacity: 0.4,
      darkOpacity: 0.25,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final tabWidth = constraints.maxWidth / tabs.length;

          return Stack(
            children: [
              // ── 滑动毛玻璃指示器 ──
              AnimatedPositioned(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeOutCubic,
                left: isUser ? 0 : tabWidth,
                top: 0,
                bottom: 0,
                width: tabWidth,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: theme.colorScheme.primary.withValues(
                            alpha: 0.3,
                          ),
                          width: 0.5,
                        ),
                        // 主题色渐变指示器
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            theme.colorScheme.primary.withValues(alpha: 0.85),
                            theme.colorScheme.primary.withValues(alpha: 0.65),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // ── Tab 文字层 ──
              Row(
                children: tabs.map((tab) {
                  final selected = tab.type == currentTab;
                  return Expanded(
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () => onTabChanged(tab.type),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        alignment: Alignment.center,
                        child: AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.easeOutCubic,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: selected
                                ? FontWeight.w600
                                : FontWeight.normal,
                            color: selected
                                ? theme.colorScheme.onPrimary
                                : theme.colorScheme.onSurfaceVariant,
                          ),
                          child: Text(tab.label),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// Tab 数据模型
class _TabData {
  final String label;
  final String type;
  const _TabData({required this.label, required this.type});
}
