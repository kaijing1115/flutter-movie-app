import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../config/config.dart';

class DioClient {
  Dio dio = Dio(BaseOptions(contentType: "application/json"))
    ..interceptors.add(CustomInterceptors());
}

class CustomInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    debugPrint('REQUEST[${options.method}] => Query: ${options.queryParameters}');
    options.queryParameters["api_key"] = apiKey;
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');
    super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    print(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
