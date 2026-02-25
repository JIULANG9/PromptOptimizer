import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

/// 打开应用商店用例
/// 负责根据平台跳转到对应的应用商店
class OpenAppStoreUseCase {
  /// 打开应用商店
  /// 
  /// [appName] 应用名称（用于搜索）
  /// 
  /// 返回 true 表示成功跳转，false 表示跳转失败
  Future<bool> call(String appName) async {
    try {
      Uri? url;

      if (Platform.isAndroid) {
        // Android: 优先尝试应用宝，失败则使用豌豆荚
        url = Uri.parse('market://search?q=$appName');
        final canLaunch = await canLaunchUrl(url);
        
        if (!canLaunch) {
          // 备用方案：豌豆荚网页版
          url = Uri.parse('https://www.wandoujia.com/search?key=$appName');
        }
      } else if (Platform.isIOS) {
        // iOS: 跳转 App Store 搜索页
        url = Uri.parse('https://apps.apple.com/cn/search?term=$appName');
      } else {
        // Web/Desktop: 不支持
        return false;
      }

      final launched = await launchUrl(
        url,
        mode: LaunchMode.externalApplication,
      );

      return launched;
    } catch (_) {
      return false;
    }
  }
}
