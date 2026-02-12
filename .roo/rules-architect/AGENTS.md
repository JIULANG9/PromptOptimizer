# AGENTS.md

This file provides guidance to agents when working with code in this repository.

## 架构规则（非显而易见）

### Riverpod Provider 定义规范
- **就近原则**: Provider 定义在与使用者同一目录，禁止集中放到 `core/providers`
- **Notifier 职责**: Notifier 类是 MVI 中的 Intent 处理器，业务逻辑必须放在这里而非 Widget
- **依赖注入**: 通过 `ProviderScope.overrides` 在 [`main.dart`](lib/main.dart:54) 中注入数据库和 Hive Box

### 数据库操作约束
- **DAO 强制使用**: 所有数据库操作必须通过 Drift DAO，禁止直接写 SQL
- **迁移规则**: 
  - 新增字段用 `m.addColumn()`（见 [`app_database.dart`](lib/database/app_database.dart:42)）
  - 删除字段必须用 `customStatement('ALTER TABLE ... DROP COLUMN ...')`（见 line 46）
- **代码生成**: 修改表定义后必须运行 `build_runner build`，`.g.dart` 文件禁止手动修改

### UI 组件使用约定
- **页面背景**: 统一使用 `GlassBackground` + `GlassScaffold`（毛玻璃极光效果）
- **列表项**: 使用 `RippleListTile`（位于 [`features/widgets/item/`](lib/features/widgets/item/)），自带毛玻璃卡片效果
- **Toast 通知**: 必须使用 `toastProvider`，错误类型用 `showError()`（自动延长显示时间）

### API 服务实现细节
- **SSE 流式响应**: OpenAI 兼容接口在 [`openai_api_service.dart`](lib/features/optimization/data/openai_api_service.dart)，自动解析 `data:` 前缀的 JSON
- **超时配置**: 发送超时 60s，接收超时 120s（流式响应需要更长的接收超时）

### 常量管理
- **硬编码禁止**: 所有魔法字符串必须在 [`app_constants.dart`](lib/core/constants/app_constants.dart) 定义
- **关键常量**: 
  - Hive box 名称: `settingsBoxName = 'app_settings_ui'`
  - 模板占位符: `{{originalPrompt}}`
  - SSE 结束标记: `[DONE]`
