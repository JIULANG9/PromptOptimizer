import 'dart:typed_data';

import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';

/// 图片仓库 — 封装图片保存到相册的平台操作
class ImageRepository {
  /// 保存图片字节数据到相册
  /// 返回 true 表示成功，false 表示失败
  Future<bool> saveImageToGallery(Uint8List imageBytes, {String? name}) async {
    try {
      final result = await ImageGallerySaverPlus.saveImage(
        imageBytes,
        quality: 100,
        name: name ?? 'qr_code_${DateTime.now().millisecondsSinceEpoch}',
      );
      // result 是 Map，包含 isSuccess 字段
      if (result is Map) {
        return result['isSuccess'] == true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
