import 'package:dio/dio.dart';
import 'package:my_task_products/core/apis/api/api_interceptor.dart';
import 'package:my_task_products/core/apis/links/end_points.dart';

import '../error/server_exception.dart';
import 'api_services.dart';

class DioServices extends ApiServices {
  final Dio dio;

  DioServices({required this.dio}) {
    dio.options.baseUrl = EndPoints.baseUrl;
    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(
      LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        error: true,
      ),
    );
  }

  @override
  delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isForm = false,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: isForm ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }

  @override
  get(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
  }) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }

  @override
  patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isForm = false,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: isForm ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }

  @override
  post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isForm = false,
  }) async {
    try {
      final response = await dio.post(
        path,
        data: isForm ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }

  @override
  Future put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Map<String, String>? headers,
    bool isForm = false,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: isForm ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      handleDioException(e);
    } catch (e) {
      throw Exception("Unexpected error: ${e.toString()}");
    }
  }
}
