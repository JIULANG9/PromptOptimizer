# AGENTS.md

This file provides guidance to agents when working with code in this repository.

## 调试规则（非显而易见）

### Hive Lock 文件问题
- **症状**: 应用启动时 Hive 报 lock 文件错误
- **解决**: [`main.dart`](lib/main.dart:24) 已内置自动清理逻辑，删除 `.lock` 文件后重新初始化
- **手动清理**: 删除 `getApplicationSupportDirectory()/hive_data/*.lock`

### 数据库迁移调试
- **查看当前版本**: 检查 `app_database.dart` 中的 `schemaVersion`
- **强制升级**: 删除应用数据目录下的 `prompt_optimizer.sqlite` 文件重新创建
- **迁移断点**: 在 `onUpgrade` 方法中添加日志追踪版本变化

### 流式响应调试
- **SSE 解析失败**: 检查 [`openai_api_service.dart`](lib/features/optimization/data/openai_api_service.dart:65) 的 `data:` 前缀匹配
- **无内容返回**: 确认 API 返回格式包含 `choices[0].delta.content`
- **超时问题**: 流式响应接收超时为 120s（发送超时的2倍），见 [`app_constants.dart`](lib/core/constants/app_constants.dart:44)

### Windows 构建问题
- **进程被占用**: 使用项目根目录的 `flutter_run.bat` 脚本，会自动清理 dart 进程和 lockfile
- **SQLite 加载失败**: 确保 `sqlite3.dll` 在构建输出目录中

### Toast 通知不显示
- **检查包裹**: 必须在 `MaterialApp.router` 中使用 `ToastHost` 包裹，见 [`app.dart`](lib/app.dart:49)
- **检查调用**: 确保使用 `ref.read(toastProvider.notifier).showXxx()` 而非直接实例化
