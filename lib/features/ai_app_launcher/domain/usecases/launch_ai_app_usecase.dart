import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

/// 启动 AI 应用用例
/// 负责复制提示词到剪贴板并跳转到指定应用
class LaunchAIAppUseCase {
  /// 启动应用
  /// 
  /// [scheme] URL Scheme（如 "doubao://"）
  /// [promptText] 要复制到剪贴板的提示词文本
  /// 
  /// 返回 true 表示成功，false 表示应用未安装或跳转失败
  Future<bool> call({
    required String scheme,
    required String promptText,
  }) async {
    try {
      // 1. 复制提示词到剪贴板
      await Clipboard.setData(ClipboardData(text: promptText));

      // 2. 构造 URL
      final url = Uri.parse(scheme);

      // 3. 检查是否可以启动
      final canLaunch = await canLaunchUrl(url);
      if (!canLaunch) {
        return false;
      }

      // 4. 启动应用（使用外部应用模式）
      final launched = await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );

      return launched;
    } on PlatformException catch (_) {
      // 平台异常（如应用未安装、系统拒绝打开）
      return false;
    } catch (_) {
      // 其他异常（如链接格式错误、网络超时）
      return false;
    }
  }
}
