import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../widgets/glass/glass_widgets.dart';
import '../../../widgets/dialogs/animated_dialog.dart';
import '../../../widgets/toast/toast_controller.dart';
import '../../domain/entities/template_entity.dart';
import '../providers/template_provider.dart';

/// 模板表单页面（新增/编辑共用）
class TemplateFormPage extends ConsumerStatefulWidget {
  final String? templateId;

  const TemplateFormPage({super.key, this.templateId});

  @override
  ConsumerState<TemplateFormPage> createState() => _TemplateFormPageState();
}

class _TemplateFormPageState extends ConsumerState<TemplateFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _systemContentController = TextEditingController();
  final _userContentController = TextEditingController();

  String _selectedType = AppConstants.templateTypeUser;
  bool _isEditing = false;
  TemplateEntity? _existingTemplate;

  static const _uuid = Uuid();

  @override
  void initState() {
    super.initState();
    _isEditing = widget.templateId != null;
    if (_isEditing) {
      _loadExistingTemplate();
    }
  }

  Future<void> _loadExistingTemplate() async {
    final useCases = ref.read(templateUseCasesProvider);
    final template = await useCases.getById(widget.templateId!);
    if (template != null && mounted) {
      final items = template.contentItems;
      setState(() {
        _existingTemplate = template;
        _nameController.text = template.name;
        _descriptionController.text = template.description;
        _selectedType = template.templateType;

        // 解析 content 填入对应编辑器
        for (final item in items) {
          if (item.role == 'system') {
            _systemContentController.text = item.content;
          } else if (item.role == 'user') {
            _userContentController.text = item.content;
          }
        }
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _systemContentController.dispose();
    _userContentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GlassScaffold(
      appBar: AppBar(
        title: Text(_isEditing ? l10n.templateEdit : l10n.templateAdd),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: GlassCard(
          padding: const EdgeInsets.all(16),
          borderRadius: BorderRadius.circular(16),
          blurSigma: 15,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 模板名称
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(labelText: l10n.templateName),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.errorNameRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 模板类型
                DropdownButtonFormField<String>(
                  initialValue: _selectedType,
                  decoration: InputDecoration(labelText: l10n.templateType),
                  items: [
                    DropdownMenuItem(
                      value: AppConstants.templateTypeUser,
                      child: Text(l10n.labelUserOptimize),
                    ),
                    DropdownMenuItem(
                      value: AppConstants.templateTypeSystem,
                      child: Text(l10n.labelSystemOptimize),
                    ),
                  ],
                  onChanged: (value) {
                    if (value != null) setState(() => _selectedType = value);
                  },
                ),
                const SizedBox(height: 16),

                // 描述
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: l10n.templateDescription,
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 24),

                // System 角色内容
                Text(
                  l10n.labelSystemRole,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _systemContentController,
                  decoration: InputDecoration(
                    hintText: l10n.templatePlaceholderHint,
                    alignLabelWithHint: true,
                  ),
                  maxLines: 6,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.errorNameRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // User 角色内容
                Text(
                  l10n.labelUserRole,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                //{{originalPrompt}} 可复制
                Text(
                  "{{originalPrompt}}",
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _userContentController,
                  decoration: InputDecoration(
                    hintText: l10n.templatePlaceholderHint,
                    alignLabelWithHint: true,
                  ),
                  maxLines: 4,
                ),
                const SizedBox(height: 32),

                // 保存按钮
                ElevatedButton(onPressed: _onSave, child: Text(l10n.btnSave)),

                // 删除按钮（仅编辑非内置模板时显示）
                if (_isEditing &&
                    _existingTemplate != null &&
                    !_existingTemplate!.isBuiltin) ...[
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: _onDelete,
                    icon: const Icon(Icons.delete_outline, size: 18),
                    label: Text(l10n.btnDelete),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.error,
                      side: BorderSide(
                        color: Theme.of(
                          context,
                        ).colorScheme.error.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// 删除模板（带确认对话框）
  void _onDelete() {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    showAnimatedDialog(
      context: context,
      builder: (ctx) => Center(
        child: AlertDialog(
          title: Text(l10n.confirmDeleteTitle),
          content: Text(l10n.templateDeleteConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.btnCancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                ref
                    .read(templateListProvider.notifier)
                    .deleteTemplate(_existingTemplate!.id);
                ref.read(toastProvider.notifier).showSuccess(l10n.toastDeleted);
                if (mounted) context.pop();
              },
              child: Text(
                l10n.btnDelete,
                style: TextStyle(color: theme.colorScheme.error),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onSave() async {
    if (!_formKey.currentState!.validate()) return;

    // 构建 content JSON
    final contentItems = <Map<String, String>>[];
    if (_systemContentController.text.trim().isNotEmpty) {
      contentItems.add({
        'role': 'system',
        'content': _systemContentController.text.trim(),
      });
    }
    if (_userContentController.text.trim().isNotEmpty) {
      contentItems.add({
        'role': 'user',
        'content': _userContentController.text.trim(),
      });
    }

    final contentJson = jsonEncode(contentItems);
    final now = DateTime.now().millisecondsSinceEpoch;
    final notifier = ref.read(templateListProvider.notifier);

    if (_isEditing && _existingTemplate != null) {
      final updated = _existingTemplate!.copyWith(
        name: _nameController.text.trim(),
        content: contentJson,
        templateType: _selectedType,
        description: _descriptionController.text.trim(),
        lastModified: now,
      );
      await notifier.updateTemplate(updated);
    } else {
      final entity = TemplateEntity(
        id: _uuid.v4(),
        name: _nameController.text.trim(),
        content: contentJson,
        templateType: _selectedType,
        description: _descriptionController.text.trim(),
        lastModified: now,
        createdAt: now,
      );
      await notifier.createTemplate(entity);
    }

    if (mounted) context.pop();
  }
}
