# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## 项目概述

Prompt Optimizer 是一个 Flutter 跨平台应用（Android/iOS/Web/Desktop），用于 AI 提示词优化。采用 **MVI 架构** + **Clean Architecture**，状态管理使用 Riverpod。

## 技术栈

| 层级 | 技术 |
|------|------|
| 框架 | Flutter 3.10+ |
| 状态管理 | Riverpod (flutter_riverpod ^2.6.1) |
| 路由 | go_router (^17.1.0) |
| 数据库 | Drift (SQLite) |
| KV 存储 | Hive |
| 网络 | Dio + SSE 流式响应 |
| 加密 | AES-256-CBC (encrypt ^5.0.3) |
| 代码生成 | build_runner, freezed, drift_dev, riverpod_generator |

## 关键命令

```bash
# 运行应用（Windows）
flutter run -d windows

# 代码生成（修改 @freezed/@DriftDatabase/@riverpod 后必须执行）
dart run build_runner build --delete-conflicting-outputs
dart run build_runner watch --delete-conflicting-outputs  # 监听模式

# 代码检查
flutter analyze
flutter test

# 代码格式化
dart format .

# 清理重建
flutter clean && flutter pub get

# 构建发布
flutter build windows --release
flutter build apk --release
flutter build appbundle --release
```

## 项目结构

```
lib/
├── main.dart              # 入口：初始化流程（Hive → DB → Seeder → ProviderScope）
├── app.dart               # 根 Widget：主题/国际化/路由配置
├── core/                  # 核心层
│   ├── bootstrap/        # 启动引导（AppBootstrapper）
│   ├── constants/        # 全局常量（AppConstants）
│   ├── crypto/           # AES 加密服务
│   ├── l10n/             # 国际化（ARB）
│   ├── routing/          # go_router 路由表
│   └── theme/            # 主题配置（AppColors/AppTheme）
├── database/             # 数据库层（Drift）
│   ├── tables/           # 表定义
│   ├── daos/             # 数据访问对象
│   ├── seed/             # 种子数据（默认模板/API 配置）
│   └── app_database.dart # 数据库核心定义 + 迁移
└── features/             # 功能模块
    ├── api_config/       # API 配置管理
    ├── history/          # 历史记录
    ├── optimization/     # 核心优化功能
    ├── settings/         # 设置（主题/语言）
    ├── template/         # 模板管理
    └── widgets/          # 共享组件（glass/toast/item）
```

## 关键约定

1. **代码生成文件**：`.g.dart`、`.freezed.dart` 必须通过 `build_runner` 自动生成，禁止手动修改

2. **初始化顺序**：Hive → Database → Seeder → ProviderScope → App（见 `AppBootstrapper`）

3. **数据库操作**：使用 Drift DAO，禁止直接写 SQL；迁移在 `app_database.dart` 中定义

4. **UI 组件规范**：
   - 页面背景：`GlassBackground` + `GlassScaffold`
   - 列表项：`RippleListTile`
   - Toast：使用 `ToastHost` 包裹，通过 `toastProvider` 控制

5. **常量管理**：所有硬编码值必须在 `AppConstants` 中定义

6. **状态管理**：
   - Notifier 处理业务逻辑（MVI 的 Intent）
   - Provider 遵循就近原则
   - 依赖注入通过 `ProviderScope.overrides`

7. **SSE 流式响应**：OpenAI 兼容接口支持逐 token 返回，需累积拼接

## 路由表

| 路径 | 页面 |
|------|------|
| `/` | 首页（优化主界面） |
| `/result` | 移动端结果页 |
| `/settings` | 设置 |
| `/settings/api-configs` | API 配置列表 |
| `/settings/templates` | 模板列表 |

## CI/CD

- **工作流**：`.github/workflows/build-and-release.yml`
- **触发**：main 分支推送（测试构建）、Git Tag（正式发布）
- **平台**：Android (APK/AAB)、Windows、macOS、Linux、Web
