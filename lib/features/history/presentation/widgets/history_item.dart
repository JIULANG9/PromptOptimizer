import 'package:flutter/material.dart';

/// 历史记录项组件 - 毛玻璃风格
/// 用于替代 ListTile，支持透明背景和毛玻璃效果
class HistoryItem extends StatelessWidget {
  final String title;
  final String time;
  final String type;
  final bool isUserType;
  final VoidCallback onTap;

  const HistoryItem({
    super.key,
    required this.title,
    required this.time,
    required this.type,
    required this.isUserType,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: theme.colorScheme.primary.withValues(alpha: 0.2),
        highlightColor: theme.colorScheme.primary.withValues(alpha: 0.1),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // 标题行
              Row(
                children: [
                  Expanded(
                    child: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Icon(
                    Icons.chevron_right,
                    size: 20,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              // 底部信息行
              Row(
                children: [
                  // 时间
                  Text(
                    time,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 12),
                  // 类型标签
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: (isUserType
                              ? theme.colorScheme.primary
                              : theme.colorScheme.secondary)
                          .withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                        color: (isUserType
                                ? theme.colorScheme.primary
                                : theme.colorScheme.secondary)
                            .withValues(alpha: 0.3),
                        width: 0.5,
                      ),
                    ),
                    child: Text(
                      type,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isUserType
                            ? theme.colorScheme.primary
                            : theme.colorScheme.secondary,
                        fontWeight: FontWeight.w600,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
