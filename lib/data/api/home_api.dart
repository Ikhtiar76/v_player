import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../model/video_endpoint.dart';
import 'api_client.dart';

class HomeApi {
  static final _apiClient = ApiClient();

  static Future<Response> getUser(int pageno) async {
    try {
      final Response response =
          await _apiClient.get(Endpoint.videos + "?page=$pageno");
      // debugPrint('API Response: ${response.data}');

      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
