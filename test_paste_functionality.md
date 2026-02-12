# 粘贴功能测试说明

## 测试步骤

### 1. Ctrl+V 粘贴测试
1. 复制一些文本到剪贴板
2. 在应用中点击输入框或结果框
3. 按 Ctrl+V
4. 验证文本是否正确粘贴到光标位置

### 2. Win+V 剪贴板历史测试
1. 确保Windows剪贴板历史已启用
2. 复制多个不同的文本到剪贴板
3. 在应用中点击输入框或结果框
4. 按 Win+V
5. 验证Windows剪贴板历史界面是否打开
6. 从历史中选择一个文本项
7. 验证文本是否正确粘贴

## 功能特性

### 输入框 (PromptInput)
- ✅ 支持 Ctrl+V 直接粘贴
- ✅ 支持 Win+V 打开剪贴板历史
- ✅ 保持原有粘贴按钮功能
- ✅ 正确处理光标位置和文本选择

### 结果框 (ResultPanel)  
- ✅ 支持 Ctrl+V 直接粘贴
- ✅ 支持 Win+V 打开剪贴板历史
- ✅ 保持原有复制功能
- ✅ 正确处理光标位置和文本选择
- ✅ 触发 onTextChanged 回调

## 技术实现

### 快捷键绑定
使用 `CallbackShortcuts` 和 `SingleActivator` 实现键盘快捷键：
- `Ctrl+V`: `LogicalKeyboardKey.keyV, control: true`
- `Win+V`: `LogicalKeyboardKey.keyV, meta: true`

### Win+V 系统调用
通过 PowerShell 调用 Windows Forms SendKeys API：
```powershell
Add-Type -AssemblyName System.Windows.Forms; 
[System.Windows.Forms.SendKeys]::SendWait('^v')
```

### 文本处理逻辑
1. 获取当前文本和光标选择
2. 替换选择范围内的文本
3. 更新光标位置到插入文本末尾
4. 触发相应的回调函数

## 兼容性
- ✅ Windows 10/11
- ✅ 支持剪贴板历史功能
- ⚠️ 其他平台仅支持 Ctrl+V
