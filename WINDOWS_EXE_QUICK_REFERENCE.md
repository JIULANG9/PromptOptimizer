# Windows EXE 打包 - 快速参考

## 核心改动一览

| 方面 | 之前 | 现在 |
|------|------|------|
| **输出格式** | `*.zip` 压缩包 | `*.exe` + `*-portable.zip` |
| **用户体验** | 需要解压后运行 | 双击直接运行 |
| **文件数量** | 1 个 ZIP | 2 个文件（EXE + ZIP） |
| **发布说明** | 仅提及 Windows 桌面应用 | 区分 EXE 和便携版 |

## 修改的工作流文件

### 1️⃣ `.github/workflows/flutter-ci.yml`
**位置**: 第 275-297 行（`build_windows` 任务）

**变更**:
```diff
- Compress-Archive -Path "$source\*" -DestinationPath "prompt-optimizer-$VERSION-windows-x86_64.zip"
+ Copy-Item "$source\runner.exe" -Destination $exeName
+ Compress-Archive -Path "$source\*" -DestinationPath "prompt-optimizer-$VERSION-windows-x86_64-portable.zip"
```

**上传步骤更新**:
```diff
- path: prompt-optimizer-*.zip
+ path: |
+   prompt-optimizer-*.exe
+   prompt-optimizer-*-portable.zip
```

### 2️⃣ `.github/workflows/release.yml`
**位置 1**: 第 39-43 行（Windows 构建配置）
```diff
- artifact_path: build/windows/runner/Release/
+ artifact_path: build/windows/x64/runner/Release/
```

**位置 2**: 第 133-142 行（新增打包步骤）
```yaml
- name: Package Windows EXE
  if: matrix.target == 'windows'
  run: |
    # 提取版本号
    $VERSION = (Select-String -Path pubspec.yaml -Pattern '^version:').Line.Split(' ')[1].Split('+')[0]
    $source = "build/windows/x64/runner/Release"
    $exeName = "prompt-optimizer-$VERSION-windows-x86_64.exe"
    # 复制 runner.exe 为 EXE
    Copy-Item "$source\runner.exe" -Destination $exeName
    # 创建便携版 ZIP
    Compress-Archive -Path "$source\*" -DestinationPath "prompt-optimizer-$VERSION-windows-x86_64-portable.zip" -Force
```

**位置 3**: 第 144-152 行（上传步骤）
```diff
- path: ${{ matrix.artifact_path }}
+ path: |
+   ${{ matrix.artifact_path }}
+   prompt-optimizer-*.exe
+   prompt-optimizer-*-portable.zip
```

**位置 4**: 第 168-176 行（Release 文件列表）
```diff
  files: |
    release-assets/android-build/**/*.apk
    release-assets/android-build/**/*.aab
    release-assets/windows-build/**/*.exe
+   release-assets/windows-build/**/*-portable.zip
    release-assets/linux-build/**
```

**位置 5**: 第 183-191 行（Release 说明）
```diff
- - **Windows**: Windows 桌面应用
+ - **Windows EXE**: 可执行文件（推荐）
+ - **Windows 便携版**: ZIP 压缩包（包含所有依赖）
```

## 工作流执行流程

### CI 流程（push 到 develop/main）
```
1. 代码分析 (analyze)
   ↓
2. Android 构建 (build_android)
   ↓
3. Windows 构建 (build_windows) ← 生成 EXE + ZIP
   ├─ flutter build windows --release
   ├─ Copy-Item runner.exe → prompt-optimizer-x.x.x-windows-x86_64.exe
   └─ Compress-Archive → prompt-optimizer-x.x.x-windows-x86_64-portable.zip
   ↓
4. Linux 构建 (build_linux)
   ↓
5. macOS 构建 (build_macos)
   ↓
6. Web 构建 (build_web)
   ↓
7. 自动创建 Tag 和 Release (create_tag_and_release)
```

### Release 流程（push Tag v*）
```
1. 矩阵构建所有平台
   ├─ Android (ubuntu-latest)
   ├─ Windows (windows-latest) ← 生成 EXE + ZIP
   ├─ Linux (ubuntu-latest)
   ├─ macOS (macos-latest)
   ├─ iOS (macos-latest)
   └─ Web (ubuntu-latest)
   ↓
2. 下载所有 artifacts
   ↓
3. 创建 GitHub Release
   └─ 自动包含所有平台的文件
```

## 输出文件示例

### 开发版本（CI 构建）
```
artifacts/
├── prompt-optimizer-1.0.0-windows-x86_64.exe           (15-50 MB)
├── prompt-optimizer-1.0.0-windows-x86_64-portable.zip  (30-80 MB)
├── prompt-optimizer-1.0.0-android-arm64v8.apk
├── prompt-optimizer-1.0.0-linux-x86_64.tar.gz
└── ...其他平台文件
```

### 发布版本（GitHub Release）
```
Release v1.0.0
├── prompt-optimizer-1.0.0-windows-x86_64.exe           ✅ 推荐
├── prompt-optimizer-1.0.0-windows-x86_64-portable.zip  (备选)
├── prompt-optimizer-1.0.0-android-arm64v8.apk
├── prompt-optimizer-1.0.0-android-google-play.aab
├── prompt-optimizer-1.0.0-linux-x86_64.tar.gz
└── ...其他文件
```

## 关键技术点

### PowerShell 脚本说明
```powershell
# 1. 提取版本号（从 pubspec.yaml）
$VERSION = (Select-String -Path pubspec.yaml -Pattern '^version:').Line.Split(' ')[1].Split('+')[0]
# 结果: "1.0.0"

# 2. 复制 EXE 文件
Copy-Item "$source\runner.exe" -Destination $exeName
# 从: build/windows/x64/runner/Release/runner.exe
# 到: prompt-optimizer-1.0.0-windows-x86_64.exe

# 3. 创建 ZIP 压缩包
Compress-Archive -Path "$source\*" -DestinationPath $zipName -Force
# 压缩: build/windows/x64/runner/Release/* 的所有内容
```

### 条件判断
```yaml
if: matrix.target == 'windows'  # 仅在 Windows 构建时执行
```

## 验证清单

- [x] `flutter-ci.yml` 第 275-297 行：Windows 打包步骤已更新
- [x] `release.yml` 第 39-43 行：artifact_path 已修正
- [x] `release.yml` 第 133-142 行：新增 Windows 打包步骤
- [x] `release.yml` 第 144-152 行：上传步骤已更新
- [x] `release.yml` 第 168-176 行：Release 文件列表已更新
- [x] `release.yml` 第 183-191 行：Release 说明已更新

## 测试方式

### 本地测试
```bash
# 构建 Release 版本
flutter build windows --release

# 检查输出目录
dir build/windows/x64/runner/Release/
# 应该看到 runner.exe 和其他依赖文件
```

### GitHub Actions 测试
1. 推送代码到 `develop` 分支
2. 等待 CI 完成
3. 检查 `build_windows` 任务的 artifacts
4. 验证是否包含 `.exe` 和 `-portable.zip` 文件

### 发布测试
```bash
# 创建 Tag
git tag v1.0.0

# 推送 Tag
git push origin v1.0.0

# 等待 GitHub Actions 完成
# 检查 Release 页面是否包含 EXE 和便携版 ZIP
```

## 常见问题

**Q: EXE 文件可以独立运行吗？**
A: 可以，但需要同目录的 DLL 文件。建议用户下载便携版 ZIP 确保包含所有依赖。

**Q: 为什么还要保留 ZIP 文件？**
A: ZIP 包含所有依赖，更加稳定可靠。EXE 用于快速启动，ZIP 用于完整分发。

**Q: 如何进一步优化文件大小？**
A: 可以使用 `flutter build windows --release --split-debug-info` 分离调试信息。

**Q: 需要代码签名吗？**
A: 可选。如果需要，可在打包步骤后添加签名命令。

## 相关文档
- `WINDOWS_EXE_PACKAGING.md` - 详细配置说明
- `WINDOWS_EXE_CHANGES_SUMMARY.md` - 完整改动总结
