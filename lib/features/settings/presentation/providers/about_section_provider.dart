import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/image_repository.dart';
import '../../domain/usecases/image_save_usecase.dart';

/// 二维码保存状态
enum QrCodeSaveStatus { idle, saving, success, error }

// ─── Providers ───

/// 图片仓库 Provider
final imageRepositoryProvider = Provider<ImageRepository>((ref) {
  return ImageRepository();
});

/// 图片保存用例 Provider
final imageSaveUseCaseProvider = Provider<ImageSaveUseCase>((ref) {
  return ImageSaveUseCase(ref.watch(imageRepositoryProvider));
});

/// 关于分区状态 Notifier（MVI Intent 处理器）
/// 管理二维码保存的异步状态
class AboutSectionNotifier extends StateNotifier<QrCodeSaveStatus> {
  final ImageSaveUseCase _useCase;

  AboutSectionNotifier(this._useCase) : super(QrCodeSaveStatus.idle);

  /// Intent: 保存二维码到相册
  Future<void> saveQrCode() async {
    state = QrCodeSaveStatus.saving;
    try {
      final success = await _useCase.saveAssetImageToGallery(
        'assets/images/wechat_discussion_group.jpg',
      );
      state = success ? QrCodeSaveStatus.success : QrCodeSaveStatus.error;
    } catch (e) {
      state = QrCodeSaveStatus.error;
    }
  }

  /// 重置状态为 idle
  void resetState() => state = QrCodeSaveStatus.idle;
}

/// 关于分区状态 Provider
final aboutSectionProvider =
    StateNotifierProvider<AboutSectionNotifier, QrCodeSaveStatus>((ref) {
      return AboutSectionNotifier(ref.watch(imageSaveUseCaseProvider));
    });
