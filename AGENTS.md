# AGENTS.md

This file provides guidance to agents when working with code in this repository.

## 项目概述
这是一个基于 Flutter + Riverpod 的跨平台 AI 提示词优化应用，采用 MVI 架构模式。

## 技术栈
- **框架**: Flutter 3.10+
- **状态管理**: Riverpod (flutter_riverpod)
- **路由**: go_router
- **数据库**: Drift (SQLite) + Hive (KV存储)
- **网络**: dio
- **代码生成**: build_runner, freezed, drift_dev, riverpod_generator

## 常用命令

```bash
# 运行应用（Windows）
flutter run -d windows

# 代码生成（必须在使用 @freezed、@DriftDatabase、@riverpod 后执行）
dart run build_runner build --delete-conflicting-outputs

# 持续监听代码生成
dart run build_runner watch --delete-conflicting-outputs

# 分析代码
flutter analyze

# 运行测试
flutter test

# 清理构建缓存
flutter clean && flutter pub get
```

## 项目结构（Clean Architecture）

```
lib/
├── core/                    # 核心层
│   ├── constants/           # 全局常量
│   ├── l10n/               # 国际化
│   ├── routing/            # 路由配置
│   └── theme/              # 主题配置
├── database/               # 数据库层（Drift）
│   ├── tables/             # 表定义
│   ├── daos/               # 数据访问对象
│   └── seed/               # 默认数据
└── features/               # 功能模块
    ├── api_config/         # API配置管理
    ├── history/            # 历史记录
    ├── optimization/       # 提示词优化（核心功能）
    ├── settings/           # 设置
    ├── template/           # 模板管理
    └── widgets/            # 共享组件
        ├── glass/          # 毛玻璃效果组件
        ├── item/           # 列表项组件
        └── toast/          # Toast通知系统
```

## 关键约定

### 1. 代码生成文件
- 所有 `.g.dart`、`.freezed.dart` 文件由 build_runner 自动生成，**禁止手动修改**
- 修改源文件后必须运行 `build_runner build` 重新生成

### 2. 数据库操作
- 使用 Drift DAO 进行数据库操作，禁止直接写 SQL
- 数据库迁移在 [`app_database.dart`](lib/database/app_database.dart:35) 中定义
- 新增字段使用 `m.addColumn`，删除字段使用 `customStatement('ALTER TABLE ...')`

### 3. 状态管理（Riverpod）
- Notifier 类负责业务逻辑和状态更新（MVI 中的 Intent 处理器）
- Provider 定义遵循就近原则，与使用者放在同一目录
- 依赖注入通过 `ProviderScope.overrides` 实现（见 [`main.dart`](lib/main.dart:54)）

### 4. UI 组件规范
- 页面背景统一使用 `GlassBackground` + `GlassScaffold`（毛玻璃极光效果）
- 列表项使用 `RippleListTile`（位于 [`features/widgets/item/`](lib/features/widgets/item/)）
- Toast 通知使用 `ToastHost` 包裹 MaterialApp，通过 `toastProvider` 控制

### 5. API 服务
- OpenAI 兼容接口实现在 [`openai_api_service.dart`](lib/features/optimization/data/openai_api_service.dart)
- 支持 SSE 流式响应，自动解析 `data:` 前缀的 JSON

### 6. 常量管理
- 所有硬编码值必须在 [`app_constants.dart`](lib/core/constants/app_constants.dart) 中定义
- 包括：Hive box 名称、API 超时时间、布局断点等

## 开发注意事项

1. **初始化顺序**: Hive → Database → Seeder → ProviderScope → App
2. **Hive 路径**: 使用 `getApplicationSupportDirectory()` 子目录避免 lock 冲突
3. **主题切换**: 通过监听 `settingsProvider` 自动触发 rebuild
4. **流式响应**: 优化结果通过 Stream 逐 token 返回，需累积拼接
