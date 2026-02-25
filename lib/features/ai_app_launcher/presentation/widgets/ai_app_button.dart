import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../data/models/ai_app_config.dart';

/// AI 应用按钮组件
/// 药丸形圆角按钮，包含图标 + 名称 + 可选操作按钮
class AIAppButton extends StatelessWidget {
  final AIAppConfigModel app;
  final VoidCallback onTap;
  final VoidCallback? onClose;
  final VoidCallback? onAdd;
  final bool showCloseButton;
  final bool showAddButton;

  const AIAppButton({
    super.key,
    required this.app,
    required this.onTap,
    this.onClose,
    this.onAdd,
    this.showCloseButton = false,
    this.showAddButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(26),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
              width: 1,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 应用图标
              _buildIcon(),
              const SizedBox(width: 8),
              // 应用名称
              Text(
                app.name,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
              // 关闭按钮
              if (showCloseButton && onClose != null) ...[
                const SizedBox(width: 4),
                InkWell(
                  onTap: onClose,
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.close,
                      size: 16,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ],
              // 添加按钮
              if (showAddButton && onAdd != null) ...[
                const SizedBox(width: 4),
                InkWell(
                  onTap: onAdd,
                  borderRadius: BorderRadius.circular(12),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      Icons.add,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  /// 构建应用图标
  Widget _buildIcon() {
    // 检查是否为 SVG 图标
    if (app.iconPath.endsWith('.svg')) {
      return SvgPicture.asset(
        app.iconPath,
        width: 24,
        height: 24,
        placeholderBuilder: (context) => _buildPlaceholder(),
      );
    }

    // PNG/JPG 图标
    return Image.asset(
      app.iconPath,
      width: 24,
      height: 24,
      errorBuilder: (context, error, stackTrace) => _buildPlaceholder(),
    );
  }

  /// 构建占位图标
  Widget _buildPlaceholder() {
    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Icon(
        Icons.apps,
        size: 16,
        color: Colors.grey.shade600,
      ),
    );
  }
}
