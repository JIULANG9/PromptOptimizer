import 'package:flutter/services.dart';

import '../../data/image_repository.dart';

/// 图片保存用例 — 封装从 assets 加载图片并保存到相册的业务逻辑
class ImageSaveUseCase {
  final ImageRepository _repository;

  ImageSaveUseCase(this._repository);

  /// 保存 assets 中的图片到设备相册
  /// [assetPath] 为完整的 assets 路径（如 "assets/images/xxx.jpg"）
  /// 返回：成功返回 true，失败返回 false
  Future<bool> saveAssetImageToGallery(String assetPath) async {
    try {
      // 从 assets 加载图片字节数据
      final ByteData imageData = await rootBundle.load(assetPath);
      final Uint8List imageBytes = imageData.buffer.asUint8List();

      // 保存到相册
      return await _repository.saveImageToGallery(imageBytes);
    } catch (e) {
      return false;
    }
  }
}
