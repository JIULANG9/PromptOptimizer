# 项目时间线 — GitHub Actions 多端构建

## 日期
2026-02-12

## 背景
此前仓库仅提供本地构建指引，缺少统一的自动化流水线，导致发布各端版本（Android APK、Windows、Linux、macOS）需要手动操作，步骤繁琐且难以复现。根据最新的 CI/CD 规划，需要在 GitHub Actions 中实现一次提交即可产出多平台制品的自动化流程，并且拆分质量保障（CI）与产物发布（Release）。

## 目标
- 标准化 Flutter CI 流程，确保 push / PR 自动执行格式校验、静态分析与测试。
- 标准化 Flutter 多端 Release 流水线，确保打 Tag 或手动触发即可产出安卓/桌面平台制品。
- 在 README 中补充两套工作流的触发方式与产物说明，方便非技术成员下载。

## 变更内容
1. 新增 `.github/workflows/flutter-ci.yml`：
   - 触发 `main` 的 push/PR。
   - 单 Job 在 Ubuntu Runner 上执行 `flutter pub get`、`dart format --set-exit-if-changed`、`flutter analyze`、`flutter test`，并通过 `actions/cache` 复用依赖。
   - 作为主干门禁，阻止不满足格式和测试要求的提交。
2. 新增 `.github/workflows/release.yml`：
   - 触发 Tag（`v*`）或手动 `workflow_dispatch`。
   - 定义 `android / windows / linux / macos` 四个 Job，在相应 Runner 上构建多端 Release，打包为 `android-apk`、`windows-app`、`linux-app`、`macos-app` Artifacts。
3. 更新 `README.md`：新增 “CI/CD：GitHub Actions” 章节，说明两套工作流的职责、触发方式及产物列表。

## 验证
- `flutter-ci.yml`、`release.yml` 经本地静态审查，命令与现有项目结构路径一致。
- README 渲染预览验证表格与 Markdown 引用格式正确。

## 风险与后续
a. macOS Job 默认使用公用 Runner，若需签名或 Notarize，需要额外配置证书/Secrets。
b. Linux Job 产物未包含 install 脚本，后续可考虑添加 AppImage 或 snap 打包步骤。
c. 建议未来增加缓存（`actions/cache`）以缩短依赖安装耗时，并在 Job 结束后通过 `flutter test` / `flutter analyze` 增加质量门禁。
