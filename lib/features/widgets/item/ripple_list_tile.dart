import 'package:flutter/material.dart';

import '../glass/glass_widgets.dart';

class RippleListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? leading;
  final VoidCallback? onTap;
  final bool showArrow;
  final bool? switchValue;
  final ValueChanged<bool>? onSwitchChanged;
  final Widget? trailing;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? contentPadding;
  final bool enabled;

  const RippleListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.onTap,
    this.showArrow = false,
    this.switchValue,
    this.onSwitchChanged,
    this.trailing,
    this.borderRadius = 16.0,
    this.margin,
    this.contentPadding,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget? trailingWidget;

    if (showArrow) {
      trailingWidget = const Icon(Icons.chevron_right);
    } else if (switchValue != null) {
      trailingWidget = Switch(
        value: switchValue!,
        onChanged: enabled ? onSwitchChanged : null,
      );
    } else if (trailing != null) {
      trailingWidget = trailing;
    }

    final isInsideSection = _RippleSectionScope.of(context);

    final listTile = ListTile(
      leading: leading,
      title: Text(title),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: trailingWidget,
      contentPadding: contentPadding,
      tileColor: Colors.transparent,
      enabled: enabled,
    );

    if (onTap != null || switchValue != null) {
      // 在 RippleSection 内部时，不再包裹 GlassCard，避免双重半透明叠加
      if (isInsideSection) {
        return Padding(
          padding: margin ?? EdgeInsets.zero,
          child: InkWell(
            onTap: enabled ? onTap : null,
            borderRadius: BorderRadius.circular(borderRadius),
            child: listTile,
          ),
        );
      }
      return Padding(
        padding:
            margin ??
            const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
        child: GlassCard(
          child: InkWell(
            onTap: enabled ? onTap : null,
            borderRadius: BorderRadius.circular(borderRadius),
            child: listTile,
          ),
        ),
      );
    }

    return Padding(
      padding: isInsideSection
          ? (margin ?? EdgeInsets.zero)
          : (margin ??
                const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0)),
      child: listTile,
    );
  }
}

class RippleSwitchListTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool value;
  final ValueChanged<bool>? onChanged;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? contentPadding;

  const RippleSwitchListTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.value,
    this.onChanged,
    this.borderRadius = 12.0,
    this.margin,
    this.contentPadding,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isInsideSection = _RippleSectionScope.of(context);

    final tile = ListTile(
      title: Text(title, style: TextStyle(color: colorScheme.onSurface)),
      subtitle: subtitle != null
          ? Text(
              subtitle!,
              style: TextStyle(color: colorScheme.onSurfaceVariant),
            )
          : null,
      trailing: Switch(value: value, onChanged: onChanged),
      tileColor: Colors.transparent,
      contentPadding: contentPadding,
    );

    final inkWell = InkWell(
      onTap: onChanged != null ? () => onChanged!(!value) : null,
      borderRadius: BorderRadius.circular(borderRadius),
      child: tile,
    );

    // 在 RippleSection 内部时，不再包裹 GlassCard，避免双重半透明叠加
    if (isInsideSection) {
      return Padding(padding: margin ?? EdgeInsets.zero, child: inkWell);
    }

    return Padding(
      padding:
          margin ?? const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      child: GlassCard(child: inkWell),
    );
  }
}

/// 内部作用域标记，用于让子组件感知自己处于 RippleSection 内部
/// 当 RippleListTile 检测到此作用域时，不再自行包裹 GlassCard，避免双重半透明叠加
class _RippleSectionScope extends InheritedWidget {
  const _RippleSectionScope({required super.child});

  static bool of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<_RippleSectionScope>() !=
        null;
  }

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) => false;
}

/// 带圆角的分组容器组件
///
/// 用于包裹多个 RippleListTile 组件，提供统一的背景和圆角效果
class RippleSection extends StatelessWidget {
  /// 子组件列表
  final List<Widget> children;

  /// 圆角半径
  final double borderRadius;

  /// 外边距
  final EdgeInsetsGeometry? margin;

  /// 背景颜色（可选，默认使用主题的 itemBackground）
  final Color? backgroundColor;

  const RippleSection({
    super.key,
    required this.children,
    this.borderRadius = 16.0,
    this.margin,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: GlassCard(
        borderRadius: BorderRadius.circular(borderRadius),
        blurSigma: 15,
        child: _RippleSectionScope(child: Column(children: children)),
      ),
    );
  }
}

/// 带圆角涟漪效果的 ExpansionTile 组件
///
/// 专门用于可展开的列表项，提供圆角涟漪效果
class RippleExpansionTile extends StatelessWidget {
  /// 标题
  final String title;

  /// 副标题（可选）
  final String? subtitle;

  /// 左侧图标（可选）
  final Widget? leading;

  /// 子项列表
  final List<Widget> children;

  /// 初始展开状态
  final bool initiallyExpanded;

  /// 涟漪圆角半径
  final double borderRadius;

  /// 外边距
  final EdgeInsetsGeometry? margin;

  /// 标题内边距
  final EdgeInsetsGeometry? tilePadding;

  /// 子项内边距
  final EdgeInsetsGeometry? childrenPadding;

  /// 展开/收起回调
  final ValueChanged<bool>? onExpansionChanged;

  const RippleExpansionTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    required this.children,
    this.initiallyExpanded = false,
    this.borderRadius = 16.0,
    this.margin,
    this.tilePadding,
    this.childrenPadding,
    this.onExpansionChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isInsideSection = _RippleSectionScope.of(context);

    final theme = Theme.of(context);

    // 用 Theme 覆盖消除 ExpansionTile 内部 Material/ListTile 的隐含背景色
    final content = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Theme(
        data: theme.copyWith(
          // 消除 ExpansionTile 内部 Material 的 canvas 背景
          canvasColor: Colors.transparent,
          // 消除 ListTile 的默认 tileColor
          listTileTheme: theme.listTileTheme.copyWith(
            tileColor: Colors.transparent,
          ),
          // 消除分割线
          dividerColor: Colors.transparent,
        ),
        child: ExpansionTile(
          title: Text(title),
          subtitle: subtitle != null ? Text(subtitle!) : null,
          leading: leading,
          shape: const Border(),
          collapsedShape: const Border(),
          backgroundColor: Colors.transparent,
          collapsedBackgroundColor: Colors.transparent,
          tilePadding: tilePadding,
          childrenPadding: childrenPadding,
          initiallyExpanded: initiallyExpanded,
          onExpansionChanged: onExpansionChanged,
          children: children,
        ),
      ),
    );

    // 在 RippleSection 内部时，不再包裹 GlassCard，避免双重半透明叠加
    if (isInsideSection) {
      return Padding(padding: margin ?? EdgeInsets.zero, child: content);
    }

    return Padding(
      padding:
          margin ?? const EdgeInsets.symmetric(horizontal: 4.0, vertical: 2.0),
      child: GlassCard(child: content),
    );
  }
}
