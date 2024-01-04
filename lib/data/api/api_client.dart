import 'package:dio/dio.dart';

import 'api_services.dart';
import 'dio_helper.dart';

class ApiClient implements ApiService {
  final _dioHelper = DioHelper();
  late Dio _dio;

  static final ApiClient _apiClient = ApiClient._init();
  factory ApiClient() {
    return _apiClient;
  }
  ApiClient._init() {
    _dio = _dioHelper.dio;
  }
// Get:-----------------------------------------------------------------------

  @override
  Future<Response> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final Response response = await _dioHelper.dio.get(
        url,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      print(url);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  // Post:-----------------------------------------------------------------------

  Future<Response> post(
    String url, {
    dynamic body,
    String? token,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    try {
      final headers = {
        'Authorization': 'Bearer $token',
      };

      final Response response = await _dio.post(
        url,
        options: Options(headers: headers),
        data: body,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Response> put(String url) {
    throw UnimplementedError();
  }
}
