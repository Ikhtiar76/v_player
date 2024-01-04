import 'package:dio/dio.dart';

abstract class ApiService {
  Future<Response> get(String url);
  Future<Response> post(String url);
}
