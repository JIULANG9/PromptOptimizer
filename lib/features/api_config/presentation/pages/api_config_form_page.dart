import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/l10n/app_localizations.dart';
import '../../../../core/routing/app_router.dart';
import '../../../widgets/glass/glass_widgets.dart';
import '../../../optimization/presentation/providers/optimization_provider.dart';
import '../../../widgets/dialogs/animated_dialog.dart';
import '../../../widgets/toast/toast_controller.dart';
import '../../../widgets/toast/toast_models.dart';
import '../../data/model_provider_service.dart';
import '../../domain/entities/api_config_entity.dart';
import '../providers/api_config_provider.dart';
import '../widgets/model_selector_dialog.dart';

/// API 配置表单页面（新增/编辑共用）
class ApiConfigFormPage extends ConsumerStatefulWidget {
  /// 编辑时传入配置 ID，新增时为 null
  final String? configId;

  const ApiConfigFormPage({super.key, this.configId});

  @override
  ConsumerState<ApiConfigFormPage> createState() => _ApiConfigFormPageState();
}

class _ApiConfigFormPageState extends ConsumerState<ApiConfigFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _apiKeyController = TextEditingController();
  final _baseUrlController = TextEditingController();
  final _modelIdController = TextEditingController();
  final _modelIdFocusNode = FocusNode();

  bool _isEditing = false;
  bool _isResetKey = false;
  bool _isTesting = false;
  bool _isLoadingModels = false;
  bool _isEnabled = true;
  ApiConfigEntity? _existingConfig;
  ModelProvider? _selectedProvider;
  // ignore: unused_field
  List<ModelInfo> _modelList = [];

  final _modelProviderService = ModelProviderService();
  static const _uuid = Uuid();

  @override
  void initState() {
    super.initState();
    _isEditing = widget.configId != null;

    // 监听 baseUrl 输入框变化，实现智能匹配
    _baseUrlController.addListener(_onBaseUrlChanged);

    if (_isEditing) {
      // 加载现有配置数据
      _loadExistingConfig();
    } else {
      // 新增时填入默认值
      _baseUrlController.text = AppConstants.defaultBaseUrl;
      _modelIdController.text = AppConstants.defaultModelId;
    }
  }

  Future<void> _loadExistingConfig() async {
    final useCases = ref.read(apiConfigUseCasesProvider);
    final config = await useCases.getById(widget.configId!);
    if (config != null && mounted) {
      setState(() {
        _existingConfig = config;
        _nameController.text = config.name;
        _baseUrlController.text = config.baseUrl;
        _modelIdController.text = config.modelId;
        _isEnabled = config.isEnabled;
      });
    }
  }

  @override
  void dispose() {
    _baseUrlController.removeListener(_onBaseUrlChanged);
    _nameController.dispose();
    _apiKeyController.dispose();
    _baseUrlController.dispose();
    _modelIdController.dispose();
    _modelIdFocusNode.dispose();
    super.dispose();
  }

  /// 监听 baseUrl 变化，智能匹配模型提供商
  void _onBaseUrlChanged() {
    final url = _baseUrlController.text.trim();
    if (url.isEmpty) {
      if (_selectedProvider != null) {
        setState(() => _selectedProvider = null);
      }
      return;
    }

    final matched = ModelProvider.matchFromUrl(url);
    if (matched != null && matched != _selectedProvider) {
      setState(() {
        _selectedProvider = matched;
        _modelList = []; // 切换提供商时清空已加载的模型列表
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GlassScaffold(
      appBar: AppBar(
        title: Text(_isEditing ? l10n.apiConfigEdit : l10n.apiConfigAdd),
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
                // 配置名称
                TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: l10n.apiConfigName,
                    hintText: AppConstants.defaultApiConfigName,
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.errorNameRequired;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // 启用状态开关
                SwitchListTile(
                  title: Text(l10n.apiConfigToggleEnabled),
                  subtitle: Text(
                    _isEnabled ? l10n.labelEnabled : l10n.labelDisabled,
                    style: TextStyle(
                      color: _isEnabled
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.error,
                      fontSize: 12,
                    ),
                  ),
                  value: _isEnabled,
                  onChanged: (value) => setState(() => _isEnabled = value),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                ),
                const SizedBox(height: 8),

                // API Key
                if (!_isEditing || _isResetKey)
                  TextFormField(
                    controller: _apiKeyController,
                    decoration: InputDecoration(
                      labelText: l10n.apiConfigApiKey,
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (!_isEditing || _isResetKey) {
                        if (value == null || value.trim().isEmpty) {
                          return l10n.errorApiKeyRequired;
                        }
                      }
                      return null;
                    },
                  )
                else
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          initialValue: '••••••••••••••••',
                          enabled: false,
                          decoration: InputDecoration(
                            labelText: l10n.apiConfigApiKey,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      TextButton(
                        onPressed: () => setState(() => _isResetKey = true),
                        child: Text(l10n.btnResetKey),
                      ),
                    ],
                  ),
                const SizedBox(height: 16),

                // Base URL（带智能匹配提示）
                TextFormField(
                  controller: _baseUrlController,
                  decoration: InputDecoration(
                    labelText: l10n.apiConfigBaseUrl,
                    helperText: _selectedProvider != null
                        ? '✓ 已匹配: ${_selectedProvider!.displayName}'
                        : null,
                    helperStyle: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontSize: 12,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return l10n.errorBaseUrlRequired;
                    }
                    final uri = Uri.tryParse(value.trim());
                    if (uri == null || !uri.hasScheme) {
                      return l10n.errorInvalidUrl;
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Model ID（带清除按钮）
                TextFormField(
                  controller: _modelIdController,
                  decoration: InputDecoration(
                    labelText: l10n.apiConfigModelId,
                    suffixIcon: _modelIdController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.close, size: 18),
                            onPressed: () {
                              _modelIdController.clear();
                              setState(() {});
                              // 让输入框获得焦点
                              FocusScope.of(context).requestFocus(FocusNode());
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                FocusScope.of(
                                  context,
                                ).requestFocus(_modelIdFocusNode);
                              });
                            },
                            tooltip: l10n.btnClearAll,
                          )
                        : null,
                  ),
                  focusNode: _modelIdFocusNode,
                  onChanged: (_) => setState(() {}),
                ),
                const SizedBox(height: 12),

                // 模型工具栏：选择提供商 + 选择模型
                _buildModelToolbar(l10n),
                const SizedBox(height: 24),

                // 测试按钮
                ElevatedButton.icon(
                  onPressed: _isTesting ? null : _onTest,
                  icon: _isTesting
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Icon(Icons.api, size: 18),
                  label: Text(_isTesting ? l10n.labelTesting : l10n.btnTest),
                ),
                const SizedBox(height: 12),

                // 保存按钮
                ElevatedButton(onPressed: _onSave, child: Text(l10n.btnSave)),

                // 删除按钮（仅编辑模式显示）
                if (_isEditing && _existingConfig != null) ...[
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

  // ─── 获取可用的 API Key ───
  // 编辑模式下优先使用持久化的解密密钥，新增模式使用输入框的值
  Future<String?> _getApiKey() async {
    // 如果用户正在输入新的 API Key，优先使用
    if (_apiKeyController.text.trim().isNotEmpty) {
      return _apiKeyController.text.trim();
    }
    // 编辑模式下，从持久化数据获取解密后的 API Key
    if (_isEditing && _existingConfig != null) {
      try {
        final useCases = ref.read(apiConfigUseCasesProvider);
        return await useCases.getDecryptedApiKey(_existingConfig!.id);
      } catch (_) {
        return null;
      }
    }
    return null;
  }

  // ─── 模型工具栏 ───
  Widget _buildModelToolbar(AppLocalizations l10n) {
    final theme = Theme.of(context);
    final hasProvider = _selectedProvider != null;

    return Row(
      children: [
        // 选择提供商按钮
        Expanded(
          child: OutlinedButton.icon(
            onPressed: _onSelectProvider,
            icon: Icon(
              _selectedProvider != null
                  ? Icons.check_circle_outline
                  : Icons.cloud_outlined,
              size: 16,
            ),
            label: Text(
              _selectedProvider?.displayName ?? l10n.btnSelectProvider,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            style: OutlinedButton.styleFrom(
              foregroundColor: hasProvider
                  ? theme.colorScheme.primary
                  : theme.colorScheme.onSurface,
              side: BorderSide(
                color: hasProvider
                    ? theme.colorScheme.primary.withValues(alpha: 0.5)
                    : theme.colorScheme.outline.withValues(alpha: 0.3),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
        ),
        const SizedBox(width: 10),
        // 选择模型按钮
        Expanded(
          child: OutlinedButton.icon(
            onPressed: hasProvider && !_isLoadingModels ? _onSelectModel : null,
            icon: _isLoadingModels
                ? const SizedBox(
                    width: 14,
                    height: 14,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.list_alt_outlined, size: 16),
            label: Text(
              _isLoadingModels ? l10n.btnLoadingModels : l10n.btnSelectModel,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
        ),
      ],
    );
  }

  // ─── 选择提供商 ───
  Future<void> _onSelectProvider() async {
    final provider = await showProviderSelectorDialog(context);
    if (provider != null && mounted) {
      setState(() {
        _selectedProvider = provider;
        _modelList = []; // 切换提供商时清空已加载的模型列表
        // 自动填入对应提供商的完整 URL（baseUrl + /chat/completions）
        _baseUrlController.text = '${provider.baseUrl}/chat/completions';
      });
    }
  }

  // ─── 选择模型（加载模型列表 → 弹出选择对话框） ───
  Future<void> _onSelectModel() async {
    final toast = ref.read(toastProvider.notifier);
    final l10n = AppLocalizations.of(context)!;

    // 获取 API Key
    final apiKey = await _getApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      toast.showError(l10n.errorApiKeyRequired);
      return;
    }

    setState(() => _isLoadingModels = true);

    try {
      final models = await _modelProviderService.fetchModels(
        provider: _selectedProvider!,
        apiKey: apiKey,
      );

      if (!mounted) return;

      setState(() {
        _modelList = models;
        _isLoadingModels = false;
      });

      if (models.isEmpty) {
        toast.showWarning(l10n.labelNoModels);
        return;
      }

      // 弹出模型选择对话框
      final selectedModelId = await showModelListDialog(
        context: context,
        models: models,
        provider: _selectedProvider!,
      );

      if (selectedModelId != null && mounted) {
        setState(() {
          _modelIdController.text = selectedModelId;
        });
      }
    } on DioException catch (e) {
      if (!mounted) return;
      setState(() => _isLoadingModels = false);
      final msg = e.response?.statusCode != null
          ? 'HTTP ${e.response!.statusCode}'
          : (e.message ?? 'Network error');
      toast.showError(l10n.errorLoadModelsFailed(msg));
    } catch (e) {
      if (!mounted) return;
      setState(() => _isLoadingModels = false);
      toast.showError(l10n.errorLoadModelsFailed(e.toString()));
    }
  }

  // ─── 测试 API 连接 ───
  Future<void> _onTest() async {
    final l10n = AppLocalizations.of(context)!;
    final toast = ref.read(toastProvider.notifier);

    // 验证必填字段
    if (_baseUrlController.text.trim().isEmpty ||
        _modelIdController.text.trim().isEmpty) {
      toast.showError(l10n.errorBaseUrlRequired);
      return;
    }

    // 获取 API Key（支持编辑模式下使用持久化数据）
    final apiKey = await _getApiKey();
    if (apiKey == null || apiKey.isEmpty) {
      toast.showError(l10n.errorApiKeyRequired);
      return;
    }

    setState(() => _isTesting = true);

    try {
      final baseUrl = _baseUrlController.text.trim();
      final modelId = _modelIdController.text.trim();

      // URL 输入框已包含完整路径，直接使用（去除尾部斜杠）
      final testUrl = baseUrl.replaceAll(RegExp(r'/+$'), '');
      final dio = Dio();
      final response = await dio.post(
        testUrl,
        options: Options(
          headers: {'Authorization': 'Bearer $apiKey'},
          receiveTimeout: const Duration(seconds: 10),
          sendTimeout: const Duration(seconds: 10),
        ),
        data: {
          'model': modelId,
          'messages': [
            {'role': 'user', 'content': 'hi'},
          ],
          'max_tokens': 1,
        },
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        toast.showSuccess(l10n.toastTestSuccess);
      } else {
        toast.showError('HTTP ${response.statusCode}');
      }
    } on DioException catch (e) {
      if (!mounted) return;
      final errorMsg = e.message ?? 'Test failed';
      toast.showError(errorMsg);
    } catch (e) {
      if (!mounted) return;
      toast.showError('Test failed: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() => _isTesting = false);
      }
    }
  }

  // ─── 删除配置（带确认弹窗） ───
  void _onDelete() {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    showAnimatedDialog(
      context: context,
      builder: (ctx) => Center(
        child: AlertDialog(
          title: Text(l10n.confirmDeleteTitle),
          content: Text(l10n.apiConfigDeleteConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(l10n.btnCancel),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(ctx);
                ref
                    .read(apiConfigListProvider.notifier)
                    .deleteConfig(_existingConfig!.id);
                ref.read(toastProvider.notifier).showSuccess(l10n.toastDeleted);
                // 删除后自动切换选中状态
                _autoSwitchAfterDelete();
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

  /// 删除后自动切换首页选中的 API 配置
  void _autoSwitchAfterDelete() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      final configs = ref.read(apiConfigListProvider).configs;
      final enabledConfigs = configs.where((c) => c.isEnabled).toList();
      final optNotifier = ref.read(optimizationProvider.notifier);
      final currentSelectedId = ref
          .read(optimizationProvider)
          .selectedApiConfigId;

      if (enabledConfigs.isNotEmpty) {
        final stillValid = enabledConfigs.any((c) => c.id == currentSelectedId);
        if (!stillValid) {
          optNotifier.selectApiConfig(enabledConfigs.first.id);
        }
      } else {
        optNotifier.selectApiConfig('');
        final l10n = AppLocalizations.of(context)!;
        ref
            .read(toastProvider.notifier)
            .showAction(
              message: l10n.apiConfigNoAvailable,
              type: ToastType.normal,
              primaryAction: ToastAction(
                label: l10n.btnAddNow,
                onPressed: () {
                  context.push(AppRouter.apiConfigNew);
                },
              ),
              duration: const Duration(seconds: 4),
            );
      }
    });
  }

  Future<void> _onSave() async {
    if (!_formKey.currentState!.validate()) return;

    final notifier = ref.read(apiConfigListProvider.notifier);

    if (_isEditing && _existingConfig != null) {
      // 更新
      final updated = _existingConfig!.copyWith(
        name: _nameController.text.trim(),
        baseUrl: _baseUrlController.text.trim(),
        modelId: _modelIdController.text.trim(),
        isEnabled: _isEnabled,
      );
      await notifier.updateConfig(
        updated,
        newApiKey: _isResetKey ? _apiKeyController.text.trim() : null,
      );
    } else {
      // 新增
      final entity = ApiConfigEntity(
        id: _uuid.v4(),
        name: _nameController.text.trim(),
        apiKey: _apiKeyController.text.trim(),
        baseUrl: _baseUrlController.text.trim(),
        modelId: _modelIdController.text.trim(),
        isEnabled: _isEnabled,
        createdAt: DateTime.now().millisecondsSinceEpoch,
      );
      await notifier.createConfig(entity);
    }

    if (mounted) context.pop();
  }
}
