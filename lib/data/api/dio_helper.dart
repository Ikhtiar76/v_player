import 'package:dio/dio.dart';

import '../../model/video_endpoint.dart';

class DioHelper {
  final dio = Dio();

  static final DioHelper _dc = DioHelper._init();

  factory DioHelper() {
    return _dc;
  }

  DioHelper._init() {
    dio
      ..options.baseUrl = Endpoint.baseUrl
      ..options.connectTimeout = Endpoint.connectionTimeout
      ..options.receiveTimeout = Endpoint.receiveTimeout
      ..options.responseType = ResponseType.json;
  }
}
