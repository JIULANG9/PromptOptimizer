import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../data/data_transfer_repository.dart';

/// 数据传输用例 — 封装导入导出的业务逻辑 + 平台文件 IO
/// 职责：编排 Repository 数据读写与平台文件操作
class DataTransferUseCases {
  final DataTransferRepository _repository;

  DataTransferUseCases(this._repository);

  /// 导出数据
  /// PC 端：弹出文件夹选择器，保存到选定目录
  /// 移动端：生成临时文件，调用系统分享
  Future<void> exportData() async {
    final jsonString = await _repository.exportToJson();
    final fileName = _generateFileName();

    if (Platform.isAndroid || Platform.isIOS) {
      // 移动端：写入临时文件 → 系统分享
      final tempDir = await getTemporaryDirectory();
      final tempFile = File(p.join(tempDir.path, fileName));
      await tempFile.writeAsString(jsonString, flush: true);

      await Share.shareXFiles([
        XFile(tempFile.path),
      ], subject: 'Prompt Optimizer Backup');
    } else {
      // PC 端：选择文件夹 → 保存文件
      final selectedDir = await FilePicker.platform.getDirectoryPath();
      if (selectedDir == null) return; // 用户取消

      final file = File(p.join(selectedDir, fileName));
      await file.writeAsString(jsonString, flush: true);
    }
  }

  /// 导入数据
  /// 弹出文件选择器，选择 JSON 文件，解析并导入
  /// 返回 true 表示成功导入，false 表示用户取消
  Future<bool> importData() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
    );

    if (result == null || result.files.isEmpty) return false;

    final filePath = result.files.single.path;
    if (filePath == null) return false;

    final file = File(filePath);
    final jsonString = await file.readAsString();

    await _repository.importFromJson(jsonString);
    return true;
  }

  /// 生成导出文件名
  String _generateFileName() {
    final now = DateTime.now();
    final timestamp =
        '${now.year}-${_pad(now.month)}-${_pad(now.day)}_${_pad(now.hour)}${_pad(now.minute)}${_pad(now.second)}';
    return 'prompt_optimizer_backup_$timestamp.json';
  }

  static String _pad(int value) => value.toString().padLeft(2, '0');
}
