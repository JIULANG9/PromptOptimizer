import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../widgets/glass/glass_widgets.dart';
import '../providers/ai_app_provider.dart';
import '../widgets/add_app_bottom_sheet.dart';
import '../widgets/ai_app_button.dart';
import '../widgets/animated_ai_app_button.dart';

/// AI 应用管理页面
/// 管理已启用/未启用的 AI 应用，支持拖拽排序和添加自定义应用
class AIAppManagerPage extends ConsumerWidget {
  const AIAppManagerPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context)!;
    final appsAsync = ref.watch(aIAppListProvider);

    return GlassScaffold(
      appBar: AppBar(
        title: Text(l10n.aiAppManager),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showAddAppBottomSheet(context),
        icon: const Icon(Icons.add),
        label: Text(l10n.addCustomApp),
      ),
      body: appsAsync.when(
        data: (apps) {
          final enabledApps = apps.where((app) => app.isEnabled).toList()
            ..sort((a, b) => a.position.compareTo(b.position));
          final disabledApps = apps.where((app) => !app.isEnabled).toList();

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // 已启用区域
              _SectionHeader(title: l10n.enabledApps),
              const SizedBox(height: 8),
              _EnabledAppsSection(apps: enabledApps),
              const SizedBox(height: 24),

              // 未启用区域
              _SectionHeader(title: l10n.disabledApps),
              const SizedBox(height: 8),
              _DisabledAppsSection(apps: disabledApps),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text('加载失败: $error'),
        ),
      ),
    );
  }
}

/// 区域标题
class _SectionHeader extends StatelessWidget {
  final String title;

  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
    );
  }
}

/// 已启用应用区域（支持拖拽排序）
class _EnabledAppsSection extends ConsumerStatefulWidget {
  final List apps;

  const _EnabledAppsSection({required this.apps});

  @override
  ConsumerState<_EnabledAppsSection> createState() =>
      _EnabledAppsSectionState();
}

class _EnabledAppsSectionState extends ConsumerState<_EnabledAppsSection> {
  late List _orderedApps;
  int? _draggingIndex;

  @override
  void initState() {
    super.initState();
    _orderedApps = List.from(widget.apps);
  }

  @override
  void didUpdateWidget(_EnabledAppsSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.apps != oldWidget.apps) {
      _orderedApps = List.from(widget.apps);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_orderedApps.isEmpty) {
      return GlassCard(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Text(
            '暂无已启用的应用',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.start,
        children: List.generate(
          _orderedApps.length,
          (index) {
            final app = _orderedApps[index];
            return _DraggableAppButton(
              key: ValueKey(app.id),
              app: app,
              index: index,
              delay: index * 100,
              isDragging: _draggingIndex == index,
              onDragStarted: () {
                HapticFeedback.mediumImpact();
                setState(() {
                  _draggingIndex = index;
                });
              },
              onDragEnd: () {
                setState(() {
                  _draggingIndex = null;
                });
                _saveOrder();
              },
              onAccept: (fromIndex) {
                if (fromIndex != index) {
                  setState(() {
                    final item = _orderedApps.removeAt(fromIndex);
                    _orderedApps.insert(index, item);
                  });
                }
              },
              onClose: () {
                HapticFeedback.lightImpact();
                ref.read(aIAppManagerProvider.notifier).toggleAppEnabled(app.id);
              },
            );
          },
        ),
      ),
    );
  }

  void _saveOrder() {
    final positions = <String, int>{};
    for (int i = 0; i < _orderedApps.length; i++) {
      positions[_orderedApps[i].id] = i;
    }
    ref.read(aIAppManagerProvider.notifier).updateAppPositions(positions);
  }
}

/// 可拖拽的应用按钮
class _DraggableAppButton extends StatelessWidget {
  final dynamic app;
  final int index;
  final int delay;
  final bool isDragging;
  final VoidCallback onDragStarted;
  final VoidCallback onDragEnd;
  final Function(int) onAccept;
  final VoidCallback onClose;

  const _DraggableAppButton({
    super.key,
    required this.app,
    required this.index,
    required this.delay,
    required this.isDragging,
    required this.onDragStarted,
    required this.onDragEnd,
    required this.onAccept,
    required this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return DragTarget<int>(
      onWillAcceptWithDetails: (details) => details.data != index,
      onAcceptWithDetails: (details) => onAccept(details.data),
      builder: (context, candidateData, rejectedData) {
        return LongPressDraggable<int>(
          data: index,
          onDragStarted: onDragStarted,
          onDragEnd: (_) => onDragEnd(),
          feedback: Material(
            elevation: 8,
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(26),
            child: Opacity(
              opacity: 0.8,
              child: AIAppButton(
                app: app,
                onTap: () {},
                showCloseButton: true,
              ),
            ),
          ),
          childWhenDragging: Opacity(
            opacity: 0.3,
            child: AIAppButton(
              app: app,
              onTap: () {},
              showCloseButton: true,
            ),
          ),
          child: AnimatedAIAppButton(
            app: app,
            mode: AnimationMode.multiple,
            index: index,
            showCloseButton: true,
            onTap: () {},
            onClose: onClose,
          ),
        );
      },
    );
  }
}

/// 未启用应用区域
class _DisabledAppsSection extends ConsumerWidget {
  final List apps;

  const _DisabledAppsSection({required this.apps});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (apps.isEmpty) {
      return GlassCard(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Text(
            '所有应用已启用',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      );
    }

    return GlassCard(
      padding: const EdgeInsets.all(16),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        alignment: WrapAlignment.start,
        children: List.generate(
          apps.length,
          (index) {
            final app = apps[index];
            return AnimatedAIAppButton(
              key: ValueKey(app.id),
              app: app,
              mode: AnimationMode.multiple,
              index: index,
              showAddButton: true,
              onTap: () {},
              onAdd: () {
                HapticFeedback.lightImpact();
                ref.read(aIAppManagerProvider.notifier).toggleAppEnabled(app.id);
              },
            );
          },
        ),
      ),
    );
  }
}
