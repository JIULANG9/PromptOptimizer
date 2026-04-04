import 'package:dio/dio.dart';
import '../../../../core/constants/app_constants.dart';
import '../models/version_response.dart';

class VersionRepository {
  final Dio _dio;

  VersionRepository(this._dio);

  Future<PromptOptimizerVersion?> fetchLatestVersion() async {
    try {
      final response = await _dio.get(
        AppConstants.versionCheckApiUrl,
        options: Options(
          sendTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
        ),
      );

      if (response.statusCode == 200 && response.data != null) {
        final versionResponse = VersionResponse.fromJson(response.data);
        return versionResponse.promptOptimizer;
      }
      return null;
    } on DioException catch (_) {
      return null;
    } catch (_) {
      return null;
    }
  }
}
