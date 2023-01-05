import 'package:blog_flutter/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'interceptor/token_interceptor.dart';

/// 厦门大学计算机专业 | 前华为工程师
///  专注《零基础学编程系列》  http://lblbc.cn/blog
///  包含：Java | 安卓 | 前端 | Flutter | iOS | 小程序 | 鸿蒙
///  公众号：蓝不蓝编程
class HttpManager {
  late Dio _dio;

  static HttpManager _instance = HttpManager._();

  HttpManager._() {
    BaseOptions options = BaseOptions(baseUrl: Constants.BASE_URL);
    _dio = Dio(options);
    _dio.interceptors.add(TokenInterceptor());
    if (kDebugMode) {
      _dio.interceptors.add(LogInterceptor(request: true, responseBody: true, error: true));
    }
  }

  static HttpManager getInstance() {
    return _instance;
  }

  Future get(String url, {Map<String, dynamic>? params}) async {
    try {
      Response response;
      response = await _dio.get(url, queryParameters: params);
      return response.data;
    } on DioError catch (e) {
      throw HttpDioError.handleError(e);
    }
  }

  Future post(String url, {dynamic data}) async {
    try {
      Response response;
      if (data == null) {
        response = await _dio.post(url);
      } else {
        response = await _dio.post(url, data: data);
      }
      return response.data;
    } on DioError catch (e) {
      throw HttpDioError.handleError(e);
    }
  }

  Future put(String url, {dynamic data}) async {
    try {
      Response response;
      if (data == null) {
        response = await _dio.put(url);
      } else {
        response = await _dio.put(url, data: data);
      }
      return response.data;
    } on DioError catch (e) {
      throw HttpDioError.handleError(e);
    }
  }

  Future delete(String url, {Map<String, dynamic>? params}) async {
    try {
      Response response;
      response = await _dio.delete(url, queryParameters: params);
      return response.data;
    } on DioError catch (e) {
      throw HttpDioError.handleError(e);
    }
  }
}

class HttpDioError {
  static const int LOGIN_CODE = -1001;

  static ResultException handleError(DioError dioError) {
    int code = 9999;
    String message = "未知错误";
    switch (dioError.type) {
      case DioErrorType.connectTimeout:
        code = 9000;
        message = "网络连接超时，请检查网络设置";
        break;
      case DioErrorType.receiveTimeout:
        code = 90001;
        message = "服务器异常，请稍后重试！";
        break;
      case DioErrorType.sendTimeout:
        code = 90002;
        message = "网络连接超时，请检查网络设置";
        break;
      case DioErrorType.response:
        code = 90003;
        message = "服务器异常，请稍后重试！";
        break;
      case DioErrorType.cancel:
        code = 90004;
        message = "请求已被取消，请重新请求";
        break;
      case DioErrorType.other:
        code = 90005;
        message = "网络异常，请稍后重试！";
        break;
    }
    return ResultException(code, message);
  }
}

class ResultException {
  final int code;
  final String message;

  ResultException(this.code, this.message);
}
