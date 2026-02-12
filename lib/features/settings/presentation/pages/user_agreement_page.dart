import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/l10n/app_localizations.dart';
import '../../../widgets/glass/glass_widgets.dart';

/// 用户协议页面
/// 从 assets 加载用户协议文本并展示
class UserAgreementPage extends StatelessWidget {
  const UserAgreementPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return GlassScaffold(
      appBar: AppBar(title: Text(l10n.settingsUserAgreement)),
      body: FutureBuilder<String>(
        future: rootBundle.loadString('assets/documents/user_agreement.txt'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData) {
            return Center(
              child: Text(
                snapshot.error?.toString() ?? 'Failed to load content',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            );
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Text(
              snapshot.data!,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(height: 1.6),
            ),
          );
        },
      ),
    );
  }
}
