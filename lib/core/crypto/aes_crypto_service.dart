import 'dart:convert';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';

import '../constants/app_constants.dart';

/// AES-256-CBC 加密/解密服务
/// 用于 API Key 的安全存储，禁止明文存储或日志输出
class AesCryptoService {
  late final Key _key;

  AesCryptoService() {
    // 从标识符派生固定长度密钥（32字节 = 256位）
    final keyBytes = utf8.encode(
      AppConstants.encryptionKeyIdentifier.padRight(
        AppConstants.aesKeyLength,
        '0',
      ),
    );
    _key = Key(
      Uint8List.fromList(keyBytes.sublist(0, AppConstants.aesKeyLength)),
    );
  }

  /// 加密明文
  /// 每次加密生成随机 IV，IV 前置于密文一起存储
  /// 返回格式: base64(IV + ciphertext)
  String encryptText(String plainText) {
    if (plainText.isEmpty) return '';

    final iv = IV.fromSecureRandom(AppConstants.aesIvLength);
    final encrypter = Encrypter(AES(_key, mode: AESMode.cbc));
    final encrypted = encrypter.encrypt(plainText, iv: iv);

    // 将 IV 和密文拼接后 base64 编码
    final combined = <int>[...iv.bytes, ...encrypted.bytes];
    return base64Encode(combined);
  }

  /// 解密密文
  /// 从存储格式中提取 IV 和密文，还原明文
  String decryptText(String encryptedText) {
    if (encryptedText.isEmpty) return '';

    final combined = base64Decode(encryptedText);

    // 前 16 字节为 IV，其余为密文
    final ivBytes = combined.sublist(0, AppConstants.aesIvLength);
    final cipherBytes = combined.sublist(AppConstants.aesIvLength);

    final iv = IV(ivBytes);
    final encrypted = Encrypted(Uint8List.fromList(cipherBytes));
    final encrypter = Encrypter(AES(_key, mode: AESMode.cbc));

    return encrypter.decrypt(encrypted, iv: iv);
  }
}
