# Windows 安装包配置说明

## 概述

本项目使用 **Inno Setup** 为 Flutter Windows 应用创建专业的 `.exe` 安装包,而不是简单的 ZIP 压缩包。

## 文件说明

### `installer.iss`
Inno Setup 脚本文件,用于配置安装包的各项参数:
- 应用名称、版本、发布者信息
- 安装目录、开始菜单项
- 桌面快捷方式、快速启动图标
- 文件包含规则
- 安装/卸载行为

## 本地构建安装包

### 前置要求
1. 安装 [Inno Setup 6](https://jrsoftware.org/isdl.php)
2. 确保已完成 Flutter Windows 构建

### 构建步骤

```powershell
# 1. 构建 Flutter Windows 应用
flutter build windows --release

# 2. 使用 Inno Setup 编译安装包
& "C:\Program Files (x86)\Inno Setup 6\ISCC.exe" windows\installer.iss

# 3. 安装包输出位置
# build\windows\installer\PromptOptimizer-{版本号}-Setup.exe
```

## GitHub Actions 自动构建

### CI/CD 流程
在 GitHub Actions 中,Windows 构建流程已配置为自动生成安装包:

1. **flutter-ci.yml** - 持续集成
   - 分支推送: 仅测试,PR 生成 ZIP
   - Tag 推送: 生成 `.exe` 安装包

2. **release.yml** - 发布流程
   - Tag 触发: 自动生成并发布 `.exe` 安装包

### 构建产物
- **正式发布**: `prompt-optimizer-{版本号}-windows-x86_64-setup.exe`
- **Pull Request**: `prompt-optimizer-{版本号}-windows-x86_64.zip` (仅测试用)

## 安装包特性

### 用户体验
- ✅ 双击即可安装,无需解压
- ✅ 自动创建开始菜单项
- ✅ 可选创建桌面快捷方式
- ✅ 标准的卸载程序
- ✅ 英文安装界面

### 技术特性
- 🔒 以用户权限安装(无需管理员)
- 📦 LZMA2 最大压缩
- 🎨 现代化安装向导界面
- 🌐 英文界面(可扩展其他语言)
- 🔧 仅支持 x64 架构

## 自定义配置

### 修改应用信息
编辑 `installer.iss` 文件中的定义:

```pascal
#define MyAppName "Prompt Optimizer"
#define MyAppPublisher "JIULANG"
#define MyAppURL "https://github.com/JIULANG9/PromptOptimizer"
```

**注意**: 如果项目中有 LICENSE 文件,可以在 `[Setup]` 部分添加:
```pascal
LicenseFile=..\LICENSE
```

### 添加中文语言支持
如果本地 Inno Setup 安装了中文语言包,可以在 `[Languages]` 部分添加:
```pascal
[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "chinesesimplified"; MessagesFile: "compiler:Languages\ChineseSimplified.isl"
```

**注意**: GitHub Actions 中的 Inno Setup 默认不包含中文语言包,因此当前配置仅使用英文。

### 修改安装选项
在 `[Tasks]` 部分调整:

```pascal
[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; Flags: unchecked
```

### 修改文件包含规则
在 `[Files]` 部分调整:

```pascal
[Files]
Source: "..\build\windows\x64\runner\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs
```

## 版本管理

安装包版本号自动从 `pubspec.yaml` 中读取:

```yaml
version: 1.0.0+1
```

安装包文件名将包含版本号: `PromptOptimizer-1.0.0-Setup.exe`

## 故障排查

### 常见问题

1. **Inno Setup 未找到**
   ```
   解决方案: 确保 Inno Setup 安装在默认路径
   C:\Program Files (x86)\Inno Setup 6\
   ```

2. **构建失败: 找不到文件**
   ```
   解决方案: 先运行 flutter build windows --release
   确保 build\windows\x64\runner\Release 目录存在
   ```

3. **版本号读取失败**
   ```
   解决方案: 检查 pubspec.yaml 中 version 字段格式
   正确格式: version: 1.0.0+1
   ```

## 参考资料

- [Inno Setup 官方文档](https://jrsoftware.org/ishelp/)
- [Flutter Windows 部署指南](https://docs.flutter.dev/deployment/windows)
- [GitHub Actions 配置](../.github/workflows/)

---

**最后更新**: 2026-02-16  
**维护者**: JIULANG
