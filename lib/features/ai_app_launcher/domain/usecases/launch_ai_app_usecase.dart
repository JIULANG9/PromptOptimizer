import 'dart:io';

import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

/// 启动 AI 应用用例
/// 负责复制提示词到剪贴板并跳转到指定应用
/// 跳转策略：优先尝试 Scheme 跳转，失败则用包名兜底（仅 Android）
class LaunchAIAppUseCase {
  /// 启动应用
  /// 
  /// [scheme] URL Scheme（如 "doubao://"）
  /// [promptText] 要复制到剪贴板的提示词文本
  /// [packageName] Android 包名（可选，用于兜底跳转）
  /// 
  /// 返回 true 表示成功，false 表示应用未安装或跳转失败
  Future<bool> call({
    required String scheme,
    required String promptText,
    String? packageName,
  }) async {
    try {
      // 1. 复制提示词到剪贴板
      await Clipboard.setData(ClipboardData(text: promptText));

      // 2. 优先尝试 Scheme 跳转
      final schemeUrl = Uri.parse(scheme);
      final canLaunchScheme = await canLaunchUrl(schemeUrl);
      
      if (canLaunchScheme) {
        final launched = await launchUrl(
          schemeUrl,
          mode: LaunchMode.externalApplication,
        );
        if (launched) return true;
      }

      // 3. Scheme 跳转失败，尝试包名兜底（仅 Android）
      if (Platform.isAndroid && packageName != null && packageName.isNotEmpty) {
        final packageUrl = Uri.parse('package:$packageName');
        final canLaunchPackage = await canLaunchUrl(packageUrl);
        
        if (canLaunchPackage) {
          final launched = await launchUrl(
            packageUrl,
            mode: LaunchMode.externalApplication,
          );
          return launched;
        }
      }

      // 4. 所有跳转方式都失败
      return false;
    } on PlatformException catch (_) {
      // 平台异常（如应用未安装、系统拒绝打开）
      return false;
    } catch (_) {
      // 其他异常（如链接格式错误、网络超时）
      return false;
    }
  }
}
