// ignore_for_file: avoid_web_libraries_in_flutter, deprecated_member_use
import 'dart:convert';
import 'dart:html' as html;

import 'package:file_picker/file_picker.dart';

import '../../data/data_transfer_repository.dart';

/// 数据传输用例 — Web 平台实现
/// 职责：编排 Repository 数据读写与 Web 文件操作
class DataTransferUseCases {
  final DataTransferRepository _repository;

  DataTransferUseCases(this._repository);

  /// 导出数据 - Web 平台
  /// 使用浏览器下载功能
  Future<void> exportData() async {
    final jsonString = await _repository.exportToJson();
    final fileName = _generateFileName();

    // 创建 Blob 对象
    final blob = html.Blob([jsonString], 'application/json');

    // 创建下载链接
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.AnchorElement(href: url)
      ..setAttribute('download', fileName)
      ..click();

    // 清理 URL
    html.Url.revokeObjectUrl(url);
  }

  /// 导入数据 - Web 平台
  /// 使用 file_picker 选择文件
  /// 返回 true 表示成功导入，false 表示用户取消
  Future<bool> importData() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['json'],
      withData: true, // Web 平台需要读取文件内容
    );

    if (result == null || result.files.isEmpty) return false;

    final fileBytes = result.files.single.bytes;
    if (fileBytes == null) return false;

    final jsonString = utf8.decode(fileBytes);
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
