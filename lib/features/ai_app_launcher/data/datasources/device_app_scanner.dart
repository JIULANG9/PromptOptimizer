import 'dart:io';

/// 设备应用扫描器
/// 用于获取设备已安装的应用列表（仅 Android 支持）
class DeviceAppScanner {
  /// 获取已安装的应用列表
  /// 
  /// 注意：由于 Flutter 限制，此实现返回空列表
  /// 完整实现需要 Android 原生代码（MethodChannel）
  Future<List<InstalledApp>> getInstalledApps() async {
    if (!Platform.isAndroid) {
      return [];
    }

    // TODO: 实现 Android 原生代码获取已安装应用
    // 需要创建 MethodChannel 并在 Android 端实现 PackageManager 查询
    // 参考：https://developer.android.com/reference/android/content/pm/PackageManager
    
    return [];
  }

  /// 搜索已安装的应用
  Future<List<InstalledApp>> searchApps(String query) async {
    final apps = await getInstalledApps();
    if (query.isEmpty) return apps;

    final lowerQuery = query.toLowerCase();
    return apps.where((app) {
      return app.name.toLowerCase().contains(lowerQuery) ||
          app.packageName.toLowerCase().contains(lowerQuery);
    }).toList();
  }
}

/// 已安装应用信息
class InstalledApp {
  final String name;
  final String packageName;
  final List<int>? iconBytes;

  const InstalledApp({
    required this.name,
    required this.packageName,
    this.iconBytes,
  });
}
