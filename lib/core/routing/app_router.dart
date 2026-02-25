import 'package:go_router/go_router.dart';

import '../../features/api_config/presentation/pages/api_config_form_page.dart';
import '../../features/api_config/presentation/pages/api_config_list_page.dart';
import '../../features/history/presentation/pages/history_detail_page.dart';
import '../../features/history/presentation/pages/history_list_page.dart';
import '../../features/optimization/presentation/pages/home_page.dart';
import '../../features/optimization/presentation/pages/result_page.dart';
import '../../features/settings/presentation/pages/about_app_page.dart';
import '../../features/ai_app_launcher/presentation/pages/ai_app_manager_page.dart';
import '../../features/settings/presentation/pages/discussion_group_page.dart';
import '../../features/settings/presentation/pages/open_source_page.dart';
import '../../features/settings/presentation/pages/privacy_policy_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../features/settings/presentation/pages/user_agreement_page.dart';
import '../../features/template/presentation/pages/template_form_page.dart';
import '../../features/template/presentation/pages/template_list_page.dart';

/// 应用路由配置
/// 所有路由统一在此管理，禁止在其他文件中直接创建路由
class AppRouter {
  AppRouter._();

  // ─── 路由路径常量 ───
  static const String home = '/';
  static const String result = '/result';
  static const String settings = '/settings';
  static const String aboutApp = '/settings/about-app';
  static const String apiConfigList = '/settings/api-configs';
  static const String apiConfigNew = '/settings/api-configs/new';
  static const String apiConfigEdit = '/settings/api-configs/:id/edit';
  static const String templateList = '/settings/templates';
  static const String templateNew = '/settings/templates/new';
  static const String templateEdit = '/settings/templates/:id/edit';
  static const String privacyPolicy = '/settings/privacy-policy';
  static const String userAgreement = '/settings/user-agreement';
  static const String openSource = '/settings/open-source';
  static const String discussionGroup = '/settings/discussion-group';
  static const String aiAppManager = '/settings/ai-app-manager';
  static const String historyList = '/history';
  static const String historyDetail = '/history/:id';

  /// 生成 API 配置编辑路径
  static String apiConfigEditPath(String id) =>
      '/settings/api-configs/$id/edit';

  /// 生成模板编辑路径
  static String templateEditPath(String id) => '/settings/templates/$id/edit';

  /// 生成历史详情路径
  static String historyDetailPath(String id) => '/history/$id';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      // ─── 首页 ───
      GoRoute(path: home, builder: (context, state) => const HomePage()),

      // ─── 优化结果页（移动端） ───
      GoRoute(path: result, builder: (context, state) => const ResultPage()),

      // ─── 设置 ───
      GoRoute(
        path: settings,
        builder: (context, state) => const SettingsPage(),
      ),

      // ─── 关于应用 ───
      GoRoute(
        path: aboutApp,
        builder: (context, state) => const AboutAppPage(),
      ),

      // ─── API 配置列表 ───
      GoRoute(
        path: apiConfigList,
        builder: (context, state) => const ApiConfigListPage(),
      ),

      // ─── API 配置新增 ───
      GoRoute(
        path: apiConfigNew,
        builder: (context, state) => const ApiConfigFormPage(),
      ),

      // ─── API 配置编辑 ───
      GoRoute(
        path: apiConfigEdit,
        builder: (context, state) =>
            ApiConfigFormPage(configId: state.pathParameters['id']),
      ),

      // ─── 模板列表 ───
      GoRoute(
        path: templateList,
        builder: (context, state) => const TemplateListPage(),
      ),

      // ─── 模板新增 ───
      GoRoute(
        path: templateNew,
        builder: (context, state) => const TemplateFormPage(),
      ),

      // ─── 模板编辑 ───
      GoRoute(
        path: templateEdit,
        builder: (context, state) =>
            TemplateFormPage(templateId: state.pathParameters['id']),
      ),

      // ─── 隐私政策 ───
      GoRoute(
        path: privacyPolicy,
        builder: (context, state) => const PrivacyPolicyPage(),
      ),

      // ─── 用户协议 ───
      GoRoute(
        path: userAgreement,
        builder: (context, state) => const UserAgreementPage(),
      ),

      // ─── 开源协议 ───
      GoRoute(
        path: openSource,
        builder: (context, state) => const OpenSourcePage(),
      ),

      // ─── 交流群 ───
      GoRoute(
        path: discussionGroup,
        builder: (context, state) => const DiscussionGroupPage(),
      ),

      // ─── AI 应用管理 ───
      GoRoute(
        path: aiAppManager,
        builder: (context, state) => const AIAppManagerPage(),
      ),

      // ─── 历史记录列表 ───
      GoRoute(
        path: historyList,
        builder: (context, state) => const HistoryListPage(),
      ),

      // ─── 历史记录详情 ───
      GoRoute(
        path: historyDetail,
        builder: (context, state) =>
            HistoryDetailPage(historyId: state.pathParameters['id']!),
      ),
    ],
  );
}
