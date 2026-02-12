import 'package:flutter/material.dart';

import '../../../../core/l10n/app_localizations.dart';

/// 开源协议页面
/// 使用 Flutter 内置 LicensePage 展示所有依赖库的开源许可证
class OpenSourcePage extends StatelessWidget {
  const OpenSourcePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return LicensePage(
      applicationName: l10n.appTitle,
      applicationVersion: '1.0.0',
      applicationLegalese: '© 2026 九狼',
    );
  }
}
