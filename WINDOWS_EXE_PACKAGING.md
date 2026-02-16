# Windows EXE 打包配置说明

## 概述

本项目已更新 GitHub Actions 工作流，支持将 Flutter Windows 应用打包为可执行的 EXE 文件，而不仅仅是 ZIP 压缩包。

## 打包方式

### 1. 可执行 EXE 文件（推荐）
- **文件名**: `prompt-optimizer-{version}-windows-x86_64.exe`
- **用途**: 直接双击运行，无需解压
- **包含内容**: 应用程序主体
- **优点**: 用户体验好，一键启动

### 2. 便携版 ZIP（备选）
- **文件名**: `prompt-optimizer-{version}-windows-x86_64-portable.zip`
- **用途**: 包含所有依赖的完整包
- **包含内容**: 所有运行时库、资源文件等
- **优点**: 可在没有依赖的系统上运行

## 工作流配置

### flutter-ci.yml 修改
在 `build_windows` 任务中，打包步骤已更新：

```yaml
- name: Package Windows
  run: |
    $VERSION = (Select-String -Path pubspec.yaml -Pattern '^version:').Line.Split(' ')[1].Split('+')[0]
    if ('${{ github.event_name }}' -eq 'pull_request') {
      $source = "build/windows/x64/runner/Debug"
      $exeName = "prompt-optimizer-$VERSION-windows-x86_64-debug.exe"
    } else {
      $source = "build/windows/x64/runner/Release"
      $exeName = "prompt-optimizer-$VERSION-windows-x86_64.exe"
    }
    # 复制 runner.exe 为带版本号的 EXE
    Copy-Item "$source\runner.exe" -Destination $exeName
    # 同时创建便携版 ZIP（包含所有依赖）
    Compress-Archive -Path "$source\*" -DestinationPath "prompt-optimizer-$VERSION-windows-x86_64-portable.zip" -Force
```

**关键点**：
- 从 `build/windows/x64/runner/{Debug|Release}` 目录中提取 `runner.exe`
- 重命名为带版本号的 EXE 文件
- 同时创建便携版 ZIP 包

### release.yml 修改
在 `build` 任务中添加了 Windows 打包步骤：

```yaml
- name: Package Windows EXE
  if: matrix.target == 'windows'
  run: |
    $VERSION = (Select-String -Path pubspec.yaml -Pattern '^version:').Line.Split(' ')[1].Split('+')[0]
    $source = "build/windows/x64/runner/Release"
    $exeName = "prompt-optimizer-$VERSION-windows-x86_64.exe"
    Copy-Item "$source\runner.exe" -Destination $exeName
    Compress-Archive -Path "$source\*" -DestinationPath "prompt-optimizer-$VERSION-windows-x86_64-portable.zip" -Force
```

同时更新了上传步骤以包含 EXE 和 ZIP 文件：

```yaml
- name: Upload ${{ matrix.target }} artifacts
  uses: actions/upload-artifact@v4
  with:
    name: ${{ matrix.artifact_name }}-build
    path: |
      ${{ matrix.artifact_path }}
      prompt-optimizer-*.exe
      prompt-optimizer-*-portable.zip
    retention-days: 30
```

## GitHub Release 发布

在创建 GitHub Release 时，会自动包含：
- `*.exe` - Windows 可执行文件
- `*-portable.zip` - Windows 便携版

Release 说明中已更新为：
```
- **Windows EXE**: 可执行文件（推荐）
- **Windows 便携版**: ZIP 压缩包（包含所有依赖）
```

## 本地测试

### 构建 Windows Release
```bash
flutter build windows --release
```

### 手动打包 EXE
```powershell
# 从 Release 目录复制 runner.exe
Copy-Item "build/windows/x64/runner/Release/runner.exe" -Destination "prompt-optimizer-1.0.0-windows-x86_64.exe"

# 创建便携版 ZIP
Compress-Archive -Path "build/windows/x64/runner/Release\*" -DestinationPath "prompt-optimizer-1.0.0-windows-x86_64-portable.zip" -Force
```

## 构建输出目录结构

```
build/windows/x64/runner/Release/
├── runner.exe                 # 主应用程序
├── flutter_windows.dll        # Flutter 核心库
├── data/                       # 应用数据文件
├── plugins/                    # 插件库
└── ...其他依赖文件
```

## 注意事项

1. **EXE 文件大小**: Flutter Windows 应用的 EXE 文件通常在 10-50MB 之间
2. **依赖库**: EXE 运行需要同目录下的 DLL 文件，因此便携版 ZIP 包含了所有必需的依赖
3. **版本号**: 版本号自动从 `pubspec.yaml` 中提取
4. **Debug vs Release**: 
   - Debug 版本用于 PR 和开发测试
   - Release 版本用于正式发布

## 故障排除

### EXE 无法运行
- 确保 Windows 系统已安装 Visual C++ Runtime
- 检查是否缺少依赖 DLL 文件
- 使用便携版 ZIP 确保包含所有依赖

### 文件大小过大
- Release 版本会进行优化，大小会小于 Debug 版本
- 可以使用 `flutter build windows --release --split-debug-info` 进一步优化

## 相关文件

- `.github/workflows/flutter-ci.yml` - CI 工作流
- `.github/workflows/release.yml` - Release 工作流
- `pubspec.yaml` - 版本号配置
