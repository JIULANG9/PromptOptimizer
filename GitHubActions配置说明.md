# GitHub Actions 配置说明

## 概述

本项目配置了两套 GitHub Actions 工作流：

1. **Flutter CI** (`flutter-ci.yml`) - 代码质量检查和测试
2. **Flutter Release Build** (`release.yml`) - 多平台构建和发布

## 工作流说明

### Flutter CI 工作流

**触发条件：**
- `main` 分支的 push
- 针对 `main` 分支的 Pull Request

**执行步骤：**
1. 代码检出
2. 设置 Java 17 和 Flutter 环境
3. 安装依赖
4. 生成 Drift 数据库代码
5. 检查代码格式
6. 静态分析
7. 运行测试
8. 验证构建（debug 模式）

### Flutter Release Build 工作流

**触发条件：**
- 推送 `v*` 格式的标签（如 `v1.0.0`）
- 手动触发（workflow_dispatch）

**支持平台：**
- Android APK 和 AAB
- Windows EXE
- Linux App
- macOS App

## 必需的 GitHub Secrets

为了正常工作，需要在 GitHub 仓库设置以下 Secrets：

### Android 签名相关（用于发布构建）

```
ANDROID_SIGNING_KEY
```
- Android 签名密钥文件的 base64 编码内容
- 获取方式：`base64 -i android/app/sign/prompt_optimization.jks`

```
ANDROID_SIGNING_KEY_ALIAS
```
- 签名密钥别名
- 默认值：`prompt_optimization`

```
ANDROID_SIGNING_KEY_PASSWORD
```
- 签名密钥密码
- 默认值：`prompt_optimization`

```
ANDROID_SIGNING_STORE_PASSWORD
```
- 签名存储密码
- 默认值：`prompt_optimization`

### 自动生成的 Secrets

```
GITHUB_TOKEN
```
- GitHub 自动提供，用于创建 Release

## 使用方法

### 1. 设置 GitHub Secrets

1. 进入 GitHub 仓库页面
2. 点击 Settings → Secrets and variables → Actions
3. 点击 "New repository secret"
4. 添加上述必需的 Secrets

### 2. 代码质量检查

每次向 `main` 分支推送代码或创建 PR 时，CI 工作流会自动运行，确保代码质量。

### 3. 发布构建

#### 方式一：标签推送
```bash
git tag v1.0.0
git push origin v1.0.0
```

#### 方式二：手动触发
1. 进入 GitHub 仓库的 Actions 页面
2. 选择 "Flutter Release Build" 工作流
3. 点击 "Run workflow"
4. 选择需要构建的平台

### 4. 下载构建产物

构建完成后，可以在以下位置获取产物：

- **Actions 页面**：进入对应的工作流运行，下载 Artifacts
- **Releases 页面**：标签推送会自动创建 Release，包含所有平台的构建产物

## 构建产物说明

### Android
- `app-release.apk`：可直接安装的 APK 文件
- `app-release.aab`：Google Play 发布用的 AAB 文件

### Windows
- `windows-release.zip`：包含 Windows 可执行文件的压缩包

### Linux
- `linux-release.tar.gz`：包含 Linux 应用文件的压缩包

### macOS
- `macos-release.zip`：包含 macOS `.app` 的压缩包

## 注意事项

1. **首次使用前**：确保已正确设置所有 GitHub Secrets
2. **签名文件**：Android 签名文件 `android/app/sign/prompt_optimization.jks` 需要存在
3. **构建时间**：多平台构建可能需要较长时间（15-30分钟）
4. **存储限制**：构建产物保留 30 天，请及时下载
5. **权限问题**：确保仓库有足够的权限运行 Actions

## 故障排除

### 构建失败常见原因

1. **缺少 Secrets**：检查是否正确设置了所有必需的 GitHub Secrets
2. **签名文件错误**：确认 Android 签名文件存在且密码正确
3. **依赖问题**：检查 `pubspec.yaml` 依赖是否兼容
4. **Flutter 版本**：工作流使用 Flutter 3.19.0，确保本地版本兼容

### 调试方法

1. 查看 Actions 运行日志
2. 检查具体的错误步骤
3. 在本地复现相同命令
4. 根据错误信息调整配置或代码

## 自定义配置

如需修改构建配置，可以编辑以下文件：

- `.github/workflows/flutter-ci.yml`：CI 工作流配置
- `.github/workflows/release.yml`：发布构建配置

常见修改项：
- Flutter 版本
- 构建参数
- 产物保留时间
- 触发条件
