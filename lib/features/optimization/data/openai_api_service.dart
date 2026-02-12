import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';

import '../../../core/constants/app_constants.dart';

/// OpenAI 兼容 API 服务 — 基于 dio 实现 SSE 流式调用
/// 支持 /v1/chat/completions 接口，解析 Server-Sent Events 响应
class OpenAiApiService {
  final Dio _dio;

  OpenAiApiService(this._dio);

  /// 流式调用 chat/completions 接口
  /// 逐 token 返回内容片段，调用方累积拼接为完整结果
  Stream<String> streamChatCompletion({
    required String baseUrl,
    required String apiKey,
    required String modelId,
    required List<Map<String, String>> messages,
  }) async* {
    // baseUrl 已包含完整路径（含 /chat/completions），直接使用
    final url = baseUrl.replaceAll(RegExp(r'/+$'), '');

    final response = await _dio.post<ResponseBody>(
      url,
      options: Options(
        headers: {
          'Authorization': 'Bearer $apiKey',
          'Content-Type': 'application/json',
          'Accept': 'text/event-stream',
        },
        responseType: ResponseType.stream,
        sendTimeout: Duration(seconds: AppConstants.apiTimeoutSeconds),
        receiveTimeout: Duration(seconds: AppConstants.apiTimeoutSeconds * 2),
      ),
      data: jsonEncode({
        'model': modelId,
        'messages': messages,
        'stream': true,
      }),
    );

    final stream = response.data?.stream;
    if (stream == null) {
      throw Exception('No response stream received');
    }

    // 解析 SSE 流：按行分割，提取 data: 前缀后的 JSON
    String buffer = '';

    await for (final chunk in stream) {
      buffer += utf8.decode(chunk);

      // SSE 事件以双换行分隔
      while (buffer.contains('\n')) {
        final lineEnd = buffer.indexOf('\n');
        final line = buffer.substring(0, lineEnd).trim();
        buffer = buffer.substring(lineEnd + 1);

        if (line.isEmpty) continue;

        // 跳过非 data 行（如 event:, id:, retry: 等）
        if (!line.startsWith('data:')) continue;

        final data = line.substring(5).trim();

        // 结束信号
        if (data == AppConstants.sseEndSignal) return;

        // 解析 JSON 提取 delta.content
        try {
          final json = jsonDecode(data) as Map<String, dynamic>;
          final choices = json['choices'] as List<dynamic>?;
          if (choices != null && choices.isNotEmpty) {
            final delta =
                (choices[0] as Map<String, dynamic>)['delta']
                    as Map<String, dynamic>?;
            final content = delta?['content'] as String?;
            if (content != null && content.isNotEmpty) {
              yield content;
            }
          }
        } catch (_) {
          // 跳过无法解析的行（如心跳、注释等）
        }
      }
    }
  }
}
