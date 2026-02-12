# Prompt Optimizer 提示词优化器

跨平台 AI 提示词优化工具，基于 Flutter 构建，支持 Android / iOS / Web / Desktop。

> 致敬 [prompt-optimizer](https://github.com/linshenkx/prompt-optimizer)


## 功能概览

- **双模式优化** — 用户提示词优化 & 系统提示词优化，顶部 Tab 切换
- **多 API 配置** — 支持多个 OpenAI 兼容 API（DashScope 等），AES-256 加密存储密钥
- **模板管理** — 内置 4 个专业模板 + 自定义模板，`{{originalPrompt}}` 占位符
- **SSE 流式响应** — 实时逐 token 展示优化结果
- **历史记录** — 自动保存优化历史，支持查看/复制/删除/清空
- **响应式布局** — 桌面端双栏（左输入右结果），移动端单栏 + 结果页
- **主题切换** — 跟随系统 / 浅色 / 深色，Material Design 3
- **数据导入导出** — 一键备份/恢复全部数据（API配置、模板、历史、选中状态），PC端文件夹选择，移动端系统分享
- **关于应用** — 隐私政策、用户协议、开源协议展示，微信交流群二维码保存
- **国际化** — 中文 (zh) / English (en)

## 未来规划
- [ ] **多端配置同步**： API 参数配置、自定义模板以及历史操作记录的跨平台同步
- [ ] **思考模式开关功能**：灵活适配不同使用场景，满足多样化需求
- [ ] **图片上传功能**：支持上传图片 + 提示词优化。
- [ ] **快捷键体系**：专为 PC 端打造全局快捷键，提升操作效率
- [ ] **导出格式选项**：支持 Markdown、PDF、Word、LaTeX 等多种格式的便捷导出
- [ ] **多语言拓展**：新增日语（ja）、韩语（ko）等语种支持，拓展国际化应用边界

## 技术架构

| 层级 | 技术选型 |
|------|---------|
| 架构模式 | MVI (Model-View-Intent) + 单向数据流 |
| 状态管理 | Riverpod (StateNotifier) |
| 路由 | go_router |
| 数据库 | Drift (SQLite) — API配置、模板、历史 |
| KV存储 | Hive — UI偏好设置（主题、语言） |
| 网络 | Dio + SSE 流式解析 |
| 加密 | encrypt (AES-256-CBC) |
| 国际化 | flutter_localizations + ARB |
| 代码生成 | build_runner + drift_dev + riverpod_generator |

## 项目结构

```
lib/
├── main.dart                    # 入口：Hive/Drift 初始化 → ProviderScope
├── app.dart                     # 根 Widget：主题/国际化/路由配置
├── core/
│   ├── constants/app_constants.dart   # 全局常量
│   ├── crypto/aes_crypto_service.dart # AES-256 加密服务
│   ├── l10n/                          # 国际化 ARB 文件
│   ├── routing/app_router.dart        # go_router 路由表
│   └── theme/                         # AppColors + AppTheme
├── database/
│   ├── tables/                        # Drift 表定义（每表一个文件）
│   │   ├── api_configs_table.dart
│   │   ├── prompt_templates_table.dart
│   │   └── optimization_histories_table.dart
│   ├── daos/                          # 数据访问对象（每表一个 DAO）
│   │   ├── api_config_dao.dart
│   │   ├── template_dao.dart
│   │   └── history_dao.dart
│   ├── seed/                          # 种子数据（首次启动默认数据）
│   │   ├── default_templates.dart
│   │   ├── default_api_configs.dart
│   │   └── database_seeder.dart
│   ├── app_database.dart              # Drift 数据库核心定义 + 迁移策略
│   └── app_database.g.dart            # 自动生成
└── features/
    ├── api_config/       # API 配置（Data → Domain → Presentation）
    ├── template/         # 模板管理（Data → Domain → Presentation）
    ├── history/          # 历史记录（Data → Domain → Presentation）
    ├── optimization/     # 核心优化流程（API Service + UseCase + UI）
    └── settings/         # 设置（Hive 存储 + 主题/语言切换）
```

## 快速开始

```bash
# 1. 安装依赖
flutter pub get

# 2. 生成代码（Drift 数据库）
dart run build_runner build --delete-conflicting-outputs

# 3. 运行
flutter run
```

## Android 发布

### 构建发布版本

```bash
# 构建 APK（用于直接安装）
flutter build apk --release

# 构建 AAB（推荐用于 Google Play 发布）
flutter build appbundle --release
```

### 签名配置

已在 `android/app/build.gradle.kts` 中配置发布签名：
- **签名文件**: `android/app/sign/prompt_optimization.jks`
- **别名**: `prompt_optimization`
- **密码**: `prompt_optimization`

详见 `@/Documentation/Android发布签名配置.md`

## 代码格式化

```bash
dart format .
```

## 路由表

| 路径 | 页面 |
|------|------|
| `/` | 首页（优化主界面） |
| `/result` | 移动端结果页 |
| `/settings` | 设置页 |
| `/settings/api-configs` | API 配置列表 |
| `/settings/api-configs/new` | 新增 API 配置 |
| `/settings/api-configs/:id/edit` | 编辑 API 配置 |
| `/settings/templates` | 模板列表 |
| `/settings/templates/new` | 新增模板 |
| `/settings/templates/:id/edit` | 编辑模板 |
| `/history` | 历史记录列表 |
| `/history/:id` | 历史记录详情 |



